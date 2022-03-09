extends Control


func _ready():	
	$AudioStreamPlayer.play()
	


func _on_VideoPlayer_finished():
	var dialog = load("res://addons/dialogs/Dialog.tscn").instance()
	dialog.dialog_resource = load("res://addons/dialogs/Resources/DialogResources/OutroDialogResource.tres")#	
	add_child(dialog)


func _on_AudioStreamPlayer_finished():
	$AudioStreamPlayer.play()
