extends Node2D


func _ready():
	pass


func _on_Area2D_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if event.is_action_pressed("ui_mouseClick"):
			self.hide()
			get_tree().root.get_node("Main/TutorialSprite").hide()


func _on_Area2D_mouse_entered():
	Input.set_custom_mouse_cursor(load("res://games/Images/fingerPoint.png"))


func _on_Area2D_mouse_exited():
	Input.set_custom_mouse_cursor(load(""))
