extends Node

onready var showDialog = false
onready var audioPosition = 0

onready var muteAudio = false

signal muteUnmute

func _ready():
	self.connect("muteUnmute", self, "volume")

func _process(delta):
	if showDialog:
		var dialog = load("res://addons/dialogs/Dialog.tscn").instance()
		dialog.dialog_resource = load("res://addons/dialogs/Resources/DialogResources/Vorlesung02DialogResource.tres")	
		dialog.rect_position = Vector2(640,720)		
		add_child(dialog)
		showDialog = false
		
	

func volume():
	if muteAudio:
		AudioServer.set_bus_mute(0, true)
		print("AUDIO MUTED")
	else:
		AudioServer.set_bus_mute(0, false)
		print("AUDIO UNMUTED")
	

func _input(event): 
	if event is InputEventKey:
		if event.is_action_pressed("ui_mute"):
			muteAudio = !muteAudio
			emit_signal("muteUnmute")
