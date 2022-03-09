extends Control


func _ready():	
	$AudioStreamPlayer.play()
	var dialog = load("res://addons/dialogs/Dialog.tscn").instance()
	dialog.dialog_resource = load("res://addons/dialogs/Resources/DialogResources/Mensa02DialogResource.tres")#	
	add_child(dialog)


func _on_VideoPlayer_finished():
	pass#$VideoPlayer.play()


func _on_AudioStreamPlayer_finished():
	$AudioStreamPlayer.play()
