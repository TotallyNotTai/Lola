extends Node2D


func _ready():
	$AudioStreamPlayer.play(Global.audioPosition)


func _on_Button_pressed():
	Global.audioPosition = $AudioStreamPlayer.get_playback_position()
	get_tree().change_scene("res://scenes/EndScreen.tscn") 


func _on_Inklusion_pressed():
	OS.shell_open("https://www.uni-frankfurt.de/44296658/Inklusionsbeauftragte")


func _on_Kontakt_pressed():
	OS.shell_open("mailto:barrierefrei@sd.uni-Frankfurt.de")
