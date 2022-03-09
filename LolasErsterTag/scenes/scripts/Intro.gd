extends Control


func _ready():	
	pass

func _on_VideoPlayer_finished():
	$MapIntro.show()
	$MapIntro.play()
	


func _on_MapIntro_finished():
	var dialog = load("res://addons/dialogs/Dialog.tscn").instance()
	dialog.dialog_resource = load("res://addons/dialogs/Resources/DialogResources/IntroDialogResource.tres")	
	add_child(dialog) 


func _on_AudioStreamPlayer_finished():
	$AudioStreamPlayer.play()
