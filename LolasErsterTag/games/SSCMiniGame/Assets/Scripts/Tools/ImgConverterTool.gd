extends Node2D

signal clicked

var toolName = "text"

func _ready():
	pass


func _on_ConvertMode_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if event.is_pressed():
			get_parent().usingTool = toolName
			emit_signal("clicked")
