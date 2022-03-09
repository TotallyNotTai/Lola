extends Node2D

signal clicked

var toolName = "lang"

func _ready():
	pass


func _on_UnlockMode_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if event.is_pressed():
			get_parent().usingTool = toolName
			emit_signal("clicked")
