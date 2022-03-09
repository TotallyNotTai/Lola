extends Node2D

signal pauseMode
signal pauseModeOver

func _ready():
	pass


func _on_Area2D_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if event.is_action_pressed("ui_mouseClick"):
			#print("Game paused before: ",get_parent().gamePaused)
			if get_parent().gamePaused == false:				
				emit_signal("pauseMode")
			elif get_parent().gamePaused == true:
				emit_signal("pauseModeOver")
			#print("Game paused after: ",get_parent().gamePaused, "\n")


func _on_Area2D_mouse_entered():
	Input.set_custom_mouse_cursor(load("res://games/Images/fingerPoint.png"))


func _on_Area2D_mouse_exited():
	Input.set_custom_mouse_cursor(load(""))
