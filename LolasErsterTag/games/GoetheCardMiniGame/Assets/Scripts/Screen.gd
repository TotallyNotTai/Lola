extends Node2D

onready var cardScene = load("res://games/GoetheCardMiniGame/Assets/Scenes/Card.tscn")


func _ready():
	var card = cardScene.instance()
	card.state = 0	
	add_child(card)

func _process(delta):
	pass
	
