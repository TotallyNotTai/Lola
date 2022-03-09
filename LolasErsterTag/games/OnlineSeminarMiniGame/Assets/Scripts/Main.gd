extends Node2D

onready var roomScene = load("res://games/OnlineSeminarMiniGame/Assets/Scenes/Room.tscn")
onready var roomName
onready var gameover = false
onready var showingTutorial = true

func _ready():
	getIssue()
	var room = roomScene.instance()	
	add_child(room)
	
	var doorNode = get_child(10).get_node("Door")
	doorNode.connect("timeForNewRoom", self, "createNewRoom")
	
	
func _process(delta):
	
	if showingTutorial:
		$TutorialSprite.show()
	else:
		$TutorialSprite.hide()
	
	if GlobalOnline.currentIssueIndex == 5 && gameover == false:
		gameOver()
	
func _input(event):
	if event is InputEventMouseButton:
		if event.is_action_pressed("ui_mouseClick"):
			GlobalOnline.runTo = get_global_mouse_position()
			GlobalOnline.startRunning = true
	
func createNewRoom():	
	#GlobalOnline.reset()
	getIssue()	
	$Timer.wait_time = 1
	$Timer.start()
	

func getIssue():
	GlobalOnline.currentIssue = GlobalOnline.allIssues[GlobalOnline.allIssuesArray[GlobalOnline.currentIssueIndex]]
	if GlobalOnline.currentIssueIndex < 5:
		GlobalOnline.currentIssueIndex += 1
	print(GlobalOnline.currentIssue)
	

func _on_Button_pressed():
	Input.set_custom_mouse_cursor(load(""))
	get_tree().change_scene("res://scenes/Onlineseminar02.tscn")

func gameOver():
	$AudioStreamPlayer.stream_paused = true
	$GameOverSound.play()
	$GameOverLabel.show()
	gameover = true
	$Timer.wait_time = 3
	$Timer.start()


func _on_Timer_timeout():
	if gameover:
		Input.set_custom_mouse_cursor(load(""))
		get_tree().change_scene("res://scenes/Onlineseminar02.tscn")
	else:		
		var room = roomScene.instance()
		add_child(room)
		
		var doorNode = get_child(10).get_node("Door")
		doorNode.connect("timeForNewRoom", self, "createNewRoom")
		$Timer.stop()


func _on_GameStartButton_pressed():
	showingTutorial = !showingTutorial	
	var node = get_node("TutorialSprite/GameStartButton")
	node.hide()
	$TutorialButtonOS.show()


func _on_AudioStreamPlayer_finished():
	$AudioStreamPlayer.play()
