extends Node2D

onready var screenScene = load("res://games/GoetheCardMiniGame/Assets/Scenes/Screen.tscn")
onready var slotScene = load("res://games/GoetheCardMiniGame/Assets/Scenes/Slot.tscn")
onready var screenPosition = Vector2(0,-130)
onready var slotPosition = Vector2(0,32)

func _ready():
	#randomize()
	#var scaleNumber = stepify(rand_range(0.1,1),0.01)
	var scale = Vector2(1, 1)
	var screen = screenScene.instance()
	screen.scale = scale
	screen.position = screenPosition	
	add_child(screen)
	
	var slot = slotScene.instance()
	slot.position = slotPosition
	add_child(slot)
	
