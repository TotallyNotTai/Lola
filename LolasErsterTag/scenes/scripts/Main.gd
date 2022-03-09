extends Node

func _ready():
	var scene = load("res://scenes/Intro.tscn")
	var currentScene = scene.instance()	
	add_child(currentScene)


