extends Node2D

signal leftClicked
signal rightClicked
signal flipClicked
signal validateClicked
signal timeToEnd

signal buttonClicked

onready var cardScene = load("res://games/GoetheCardMiniGame/Assets/Scenes/Card.tscn")
onready var cardSpawnPoint = Vector2(640,630)

onready var machineScene = load("res://games/GoetheCardMiniGame/Assets/Scenes/Machine.tscn")
onready var machineSpawnPoint = Vector2(640,278)

onready var gameover = false

func _ready():
	GlobalCard.newGame = true
	self.connect("buttonClicked", self, "playSound")
	self.connect("timeToEnd", self, "gameOver")
	
func _process(delta):
	
	$CVPoint.text = str(GlobalCard.totalCardsValidated)
	$CNVPoint.text = str(GlobalCard.totalCardsNotValidated)
	
	if GlobalCard.totalCardsValidated + GlobalCard.totalCardsNotValidated == 5 && gameover == false:
		emit_signal("timeToEnd")
	
	if GlobalCard.newGame && gameover == false:
		GlobalCard.reset()
		newGame()
		GlobalCard.newGame = false
		
	
func newGame():	
	if has_node("Card"):
		get_tree().root.find_node("Card", true, false).queue_free()
	if has_node("Machine"):
		get_tree().root.find_node("Machine", true, false).queue_free()
		
	$CardValidatedSound.play()
	$TimerNewGame.pause_mode = false
	$TimerNewGame.wait_time = 1
	$TimerNewGame.start()
	

func gameOver():
	if has_node("Card"):
		get_tree().root.find_node("Card", true, false).queue_free()
	if has_node("Machine"):
		get_tree().root.find_node("Machine", true, false).queue_free()
	gameover = true
	$GameOver.show()
	$Timer.wait_time = 3
	$Timer.start()

func _on_ButtonRotLeft_pressed():
	emit_signal("buttonClicked")
	emit_signal("leftClicked")
	pass # Replace with function body.


func _on_ButtonRotRight_pressed():
	emit_signal("buttonClicked")
	emit_signal("rightClicked")
	pass # Replace with function body.


func _on_ButtonFlip_pressed():
	emit_signal("buttonClicked")
	emit_signal("flipClicked")
	pass # Replace with function body.


func _on_Button_pressed():
	get_tree().change_scene("res://scenes/Validierer02.tscn")
	


func _on_ButtonValidate_pressed():
	emit_signal("buttonClicked")
	emit_signal("validateClicked")


func _on_Timer_timeout():
	get_tree().change_scene("res://scenes/Validierer02.tscn")


func _on_TimerNewGame_timeout():
	var card = cardScene.instance()
	card.state = 2
	card.position = cardSpawnPoint
	add_child(card)
	
	var machine = machineScene.instance()
	machine.position = machineSpawnPoint
	add_child(machine)
	
	$TimerNewGame.stop()
	$TimerNewGame.pause_mode = true

func playSound():
	$ButtonClickSound.play()

func _on_AudioStreamPlayer_finished():
	$AudioStreamPlayer.play()
