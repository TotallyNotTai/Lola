extends Node2D

onready var paper 
onready var correctAnswers = 0
onready var wrongAnswers = 0
onready var totalAnswers = 0
onready var points = 0
onready var failedTimes = 5
export var timerWaitTime = 10

onready var changeColorMode = false
onready var buy = false

onready var createPaper 

onready var gamePaused = true

onready var showingTutorial = true

onready var timerOnce = true

signal coingone

func _ready():
	createPaper = true	
	self.connect("coingone",self,"playCoinGone")
	

func _process(delta):	
	
	if changeColorMode == true && points == 60:
		$ColorblindLabel.show()
	
	if failedTimes > 4:
		$coinGold.show()
	else:
		$coinGold.hide()
	
	if failedTimes > 3:
		$coinGold2.show()
	else:
		$coinGold2.hide()
		
	if failedTimes > 2:
		$coinGold3.show()
	else:
		$coinGold3.hide()	
		
	if failedTimes > 1:
		$coinGold4.show()
	else:
		$coinGold4.hide()	
		
	if failedTimes > 0:
		$coinGold5.show()
	else:
		$coinGold5.hide()				
	
	$Pointstext.text = str(points)
		
	
	if failedTimes == 0 && timerOnce == true:
		$AudioStreamPlayer.stream_paused = true
		$GameOverSound.play()
		gamePaused = true
		$ColorblindLabel.text = "Leider konnte Leo die Aufgaben nicht lösen."
		$Timer.wait_time = 6
		$Timer.start()	
		timerOnce = false
	
	if showingTutorial:
		$TutorialSprite.show()
	else:
		$TutorialSprite.hide()
	
	if gamePaused == false:
		if createPaper == true:
			createNewPaper()
		
		if points == 50:
			changeColorMode = true
				
	
func createNewPaper():
	var scene = load("res://games/VorlesungMiniGame/Assets/Scenes/Paper.tscn")
	paper = scene.instance()
	paper.position = Vector2(get_node("Field").position)
	if changeColorMode:
		paper.colorBlindMode = true
	else:
		paper.colorBlindMode = false		
	add_child(paper)	
	createPaper = false
	

func _on_ButtonBuy_pressed():
	$ButtonClick.play()
	if gamePaused == false:
		if paper.buy == true:
			points += 10	
		else:
			if points != 0:
				points -= 10
			failedTimes -= 1
			emit_signal("coingone")
		timerReset()
	


func _on_ButtonSell_pressed():
	$ButtonClick.play()
	if gamePaused == false:
		if paper.buy == false:
			points += 10	
		else:
			if points != 0:
				points -= 10
			failedTimes -= 1
			emit_signal("coingone")
		timerReset()


func _on_Timer_timeout():
	get_tree().change_scene("res://scenes/Vorlesung02.tscn") 
		

func timerReset():
	paper.destroy()
	createPaper = true


func _on_Button_pressed():
	get_tree().change_scene("res://scenes/Vorlesung02.tscn") 


func _on_GameStartButton_pressed():
	showingTutorial = !showingTutorial
	gamePaused = !gamePaused
	var node = get_node("TutorialSprite/GameStartButton")
	node.hide()
	$TutorialButton.show()


func _on_ButtonBuy_mouse_entered():
	Input.set_custom_mouse_cursor(load("res://games/Images/fingerPoint.png"))


func _on_ButtonBuy_mouse_exited():
	Input.set_custom_mouse_cursor(load(""))


func _on_ButtonSell_mouse_entered():
	Input.set_custom_mouse_cursor(load("res://games/Images/fingerPoint.png"))


func _on_ButtonSell_mouse_exited():
	Input.set_custom_mouse_cursor(load(""))


func _on_AudioStreamPlayer_finished():
	$AudioStreamPlayer.play()


func playCoinGone():
	$CoinGoneSound.play()

