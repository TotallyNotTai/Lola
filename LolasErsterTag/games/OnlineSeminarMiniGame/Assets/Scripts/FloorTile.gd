extends Node2D


func _ready():
	pass


func _on_Area2D_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if event.is_action_pressed("ui_mouseClick"):
			var vec = Vector2(get_global_mouse_position().x +20, get_global_mouse_position().y)
			GlobalOnline.runTo = vec
			GlobalOnline.startRunning = true
