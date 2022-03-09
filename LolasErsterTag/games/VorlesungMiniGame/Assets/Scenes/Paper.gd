extends Node2D

enum {
	GreenUP,
	GreenDown,
	RedUp,
	RedDown
}

var greenUpImage = load("res://games/VorlesungMiniGame/Assets/Images/GU.png")
var greenDownImage = load("res://games/VorlesungMiniGame/Assets/Images/GD.png")
var redUpImage = load("res://games/VorlesungMiniGame/Assets/Images/RU.png")
var redDownImage = load("res://games/VorlesungMiniGame/Assets/Images/RD.png")
var orangeUpImage = load("res://games/VorlesungMiniGame/Assets/Images/OU.png")
var orangeDownImage = load("res://games/VorlesungMiniGame/Assets/Images/OD.png")
	
var arrowScale = 0.5
var direction = Vector2.RIGHT
var SPEED = 100
var state = GreenUP
var buy = false
var animate = false
var colorBlindMode = false

var mainNode
onready var TweenNode = get_node("Tween")

func _ready():	
	randomize()
	state = choose([GreenUP, GreenDown,	RedUp,	RedDown])
	
	match state:
		GreenUP:
			if colorBlindMode:				
				get_node("Arrow").set("texture", orangeUpImage)
				get_node("Arrow").set("scale", Vector2(arrowScale, arrowScale))
			else:
				get_node("Arrow").set("texture", greenUpImage)
				get_node("Arrow").set("scale", Vector2(arrowScale, arrowScale))				
			buy = true
		RedDown:
			if colorBlindMode:				
				get_node("Arrow").set("texture", orangeDownImage)
				get_node("Arrow").set("scale", Vector2(arrowScale, arrowScale))
			else:
				get_node("Arrow").set("texture", redDownImage)
				get_node("Arrow").set("scale", Vector2(arrowScale, arrowScale))
			buy = true
		GreenDown:
			if colorBlindMode:				
				get_node("Arrow").set("texture", orangeDownImage)
				get_node("Arrow").set("scale", Vector2(arrowScale, arrowScale))
			else:
				get_node("Arrow").set("texture", greenDownImage)
				get_node("Arrow").set("scale", Vector2(arrowScale, arrowScale))
			buy = false
		RedUp:
			if colorBlindMode:				
				get_node("Arrow").set("texture", orangeUpImage)
				get_node("Arrow").set("scale", Vector2(arrowScale, arrowScale))
			else:
				get_node("Arrow").set("texture", redUpImage)
				get_node("Arrow").set("scale", Vector2(arrowScale, arrowScale))
			buy = false
			
	animate = true
	
func _process(delta):
	if animate:
		TweenNode.interpolate_property(self, "scale", Vector2(0.0,0.5), Vector2(1,1), 1, Tween.TRANS_BOUNCE, Tween.EASE_OUT)
		TweenNode.start()
		animate = false
		
		
func destroy():
	TweenNode.interpolate_property(self, "position", self.position, Vector2(720,0), 1, Tween.TRANS_BOUNCE, Tween.EASE_OUT)
	TweenNode.start()
	queue_free()


func choose(array):
	array.shuffle()
	return array.front()
	


func _on_AudioStreamPlayer_finished():
	pass # Replace with function body.
