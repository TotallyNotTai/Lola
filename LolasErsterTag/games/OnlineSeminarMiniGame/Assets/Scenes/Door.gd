extends Area2D

signal timeForNewRoom

func _ready():
	pass


func _on_Door_body_entered(body):
	if body.name == "Player":
		emit_signal("timeForNewRoom")


func _on_Door_mouse_entered():
	Input.set_custom_mouse_cursor(load("res://games/OnlineSeminarMiniGame/Assets/Images/arrowUp.png"))


func _on_Door_mouse_exited():
	Input.set_custom_mouse_cursor(load("res://games/OnlineSeminarMiniGame/Assets/Images/crosshair.png"))



func _on_Door_visibility_changed():
	$DoorOpenSound.play()
