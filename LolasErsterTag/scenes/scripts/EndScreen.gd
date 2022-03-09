extends Node2D

var url = "https://online-eval.studiumdigitale.uni-frankfurt.de/evasys/online.php?p=AuswertungSeriousGames"

func _ready():
	$AudioStreamPlayer.play(Global.audioPosition)


func _on_Button_pressed():
	OS.shell_open(url)


func _on_Credits_pressed():
	Global.audioPosition = $AudioStreamPlayer.get_playback_position()
	get_tree().change_scene("res://scenes/Credits.tscn") 


func _on_AudioStreamPlayer_finished():
	$AudioStreamPlayer.play()
