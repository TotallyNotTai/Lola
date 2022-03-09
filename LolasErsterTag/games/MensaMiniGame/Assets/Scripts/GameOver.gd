extends Node2D


func _ready():
	$Points.text = GlobalCard.totalPoints as String

func _process(delta):
	pass


func _on_Button_pressed():
	GlobalCard.totalPoints = 0
	get_tree().change_scene("res://Assets/Scenes/Main.tscn")
