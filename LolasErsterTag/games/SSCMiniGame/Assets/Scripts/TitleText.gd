extends Node2D

var choice = [true, false]
var correctTitle
var titleList = ["Formular für die Prüfungsanmeldung.pdf"]

func _ready():
	var mainNode = get_parent()
	mainNode.connect("showStatus", self, "symbolActivation")
	choice.shuffle()
	correctTitle = choice[0]

func _process(delta):
	if correctTitle:
		$Label.text = titleList[0]
		get_parent().titleTextDone = true
		$icon.hide()
	else:
		$Label.text = "A13215325BWL23134.pdf"
		$icon.show()
		
func symbolActivation():
	if correctTitle:		
		$cross.hide()
		$tick.show()
	else:
		$cross.show()
		$tick.hide()
	

func _on_Area2D_mouse_entered():
	$ring.visible = true 


func _on_Area2D_mouse_exited():
	$ring.visible = false


func _on_Area2D_input_event(viewport, event, shape_idx):
	if event is InputEventMouse:
		if event.is_pressed():
			if get_parent().isUnlocked:
				match get_parent().mode:
					"title":
						correctTitle = true
						$AudioStreamPlayer.play()
					
