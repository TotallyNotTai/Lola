extends Node2D

var timerOnce = true
signal gameover

func _ready():
	$Timer.pause_mode = true
	var menuNode = get_tree().root.get_node("Main/Menu")
	menuNode.connect("gameOver",self,"changeScene")

func _process(delta):
	
	if GlobalMensa.showingTutorial:
		$TutorialImage.show()
	else:
		$TutorialImage.hide()
		

func _on_Button_pressed():
	get_tree().change_scene("res://scenes/Mensa02.tscn")


func _on_GameStartButton_pressed():
	GlobalMensa.gamePaused = false
	GlobalMensa.showingTutorial = false
	var node = get_node("TutorialImage/GameStartButton")
	node.hide()
	$TutorialButton.show()
	
func changeScene():	
	emit_signal("gameover")
	var screenNode = get_node("Menu/Screen")
	screenNode.gameOver = true
	screenNode.get_node("ScreenTextItemName").text = "SPIEL VORBEI!"	
	screenNode.get_node("ScreenTextAllergies").text = "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"
	GlobalMensa.gamePaused = true
	if timerOnce:
		$Timer.pause_mode = false
		$Timer.wait_time = 5
		$Timer.start()
		timerOnce = false


func _on_Timer_timeout():
	get_tree().change_scene("res://scenes/Mensa02.tscn")


func _on_AudioStreamPlayer_finished():
	$AudioStreamPlayer.play()


func _on_BackgroundNoise_finished():
	$BackgroundNoise.play()
