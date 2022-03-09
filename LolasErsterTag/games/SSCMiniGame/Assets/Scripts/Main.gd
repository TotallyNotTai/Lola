extends Node2D

onready var points = 0

var paperScene = load("res://games/SSCMiniGame/Assets/Scenes/PaperElements/Paper.tscn")

var usingTool = "normal"

onready var EditToolNode = get_node("EditTool")

signal validatePaper
signal createNewPaper
signal endGame

var tempTool

var totalPapersDone = 0
var showGameOver = false

onready var showingTutorial = true
onready var gamePaused = true
onready var timerLastCount

func _ready():
	$Timer.pause_mode = true
	self.connect("createNewPaper",self, "createPaper")
	self.connect("endGame",self, "gameOver")
	
	var editTool = get_node("EditTool")
	var taggingTool = get_node("TaggingTool")
	var langTool = get_node("LangTool")
	var imCoTool = get_node("ImgConverterTool")
	var tcTool = get_node("TitleChangeTool")
	editTool.connect("clicked", self, "playClickSound")
	taggingTool.connect("clicked", self, "playClickSound")
	langTool.connect("clicked", self, "playClickSound")
	imCoTool.connect("clicked", self, "playClickSound")
	tcTool.connect("clicked", self, "playClickSound")
	
	var tutButtonNode = get_node("TutorialButton")
	tutButtonNode.connect("pauseMode", self, "pause")
	tutButtonNode.connect("pauseModeOver", self, "pauseOver")
	
	#emit_signal("createNewPaper")

func _process(delta):
	if showingTutorial:
		$TutorialSprite.show()
	else:
		$TutorialSprite.hide()		
	
	if gamePaused == false:		
		$TimeCounter.text = stepify($Timer.time_left, 1) as String
		
		$TotalPapers.text = str(totalPapersDone)
		
		if !has_node("Paper") && totalPapersDone < 10:
			emit_signal("createNewPaper")
		
		if totalPapersDone == 5 && showGameOver == false:		
			emit_signal("endGame", "PointsReached")
			showGameOver = true
		
func playClickSound():
	$ButtonClickSound.play()
	
func createPaper():
	var paperScene = load("res://games/SSCMiniGame/Assets/Scenes/PaperElements/Paper.tscn")
	var paper = paperScene.instance()
	paper.position = Vector2(400,-700)
	paper.scale = Vector2(1.15,1.15)
	add_child(paper)
	

func _on_Timer_timeout():
	gameOver("TimeUp")
	

func gameOver(text):
	if text == "PointsReached":
		$AudioStreamPlayer.stream_paused = true
		$GameOverSound.play()
		$GameOverScreen.text = "ALLE DOKUMENTE\nBEARBEITET !!!"		
	elif text == "TimeUp":
		get_node("Paper").queue_free()
		$GameOverScreen.text = "Leider ist die Zeit um!"
	$GameOverScreen.show()
	$TimerAfterFinish.wait_time = 3
	$TimerAfterFinish.start()

func _on_Button_pressed():
	get_tree().change_scene("res://scenes/Prüfungsamt02.tscn")


func _on_CheckDocument_pressed():
	playClickSound()
	emit_signal("validatePaper")


func _on_CheckDocument_mouse_entered():
	tempTool = usingTool
	usingTool = "normal"
	#get_node("Panel/Label").text = "Dokument validieren\n\nDie Validierung zeigt an wie gut das Dokument barrierefrei gemacht wurde."


func _on_CheckDocument_mouse_exited():
	usingTool = tempTool
	tempTool = ""


func _on_TimerAfterFinish_timeout():
	get_tree().change_scene("res://scenes/Prüfungsamt02.tscn")


func _on_GameStartButton_pressed():
	gamePaused = false
	showingTutorial = false
	get_node("TutorialSprite/GameStartButton").hide()
	$Timer.pause_mode = false
	$Timer.wait_time = 300
	$Timer.start()
	$TutorialButton.show()

func pause():
	gamePaused = true
	showingTutorial = true
	timerLastCount = $Timer.time_left
	$Timer.pause_mode = true

func pauseOver():
	gamePaused = false
	showingTutorial = false	
	$Timer.pause_mode = false
	$Timer.wait_time = timerLastCount
	$Timer.start()


func _on_AudioStreamPlayer_finished():
	$AudioStreamPlayer.play()
