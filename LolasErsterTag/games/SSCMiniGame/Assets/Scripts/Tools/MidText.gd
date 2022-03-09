extends Node2D

var choice = [true, false]

var isTagged = false
var isImage = false


func _ready():
	var mainNode = get_parent()
	mainNode.connect("showStatus", self, "symbolActivation")
	
	choice.shuffle()
	isTagged = choice[0]
	choice.shuffle()
	isImage = choice[0]
	
func _process(delta):
	if isTagged == true && isImage == false:
		get_parent().midTextDone = true
		
	match isTagged:
		true:
			$tag.visible = true
		false:
			$tag.visible = false
	
	match isImage:
		true:
			$image.visible = true
			$text.visible = false
		false:
			$image.visible = false
			$text.visible = true

func symbolActivation():
	if get_parent().midTextDone:
		$cross.hide()
		$tick.show()
	else:
		$cross.show()
		$tick.hide()


func _on_Area2D_input_event(viewport, event, shape_idx):
	if event is InputEventMouse:
		if event.is_pressed():
			if get_parent().isUnlocked:
				match get_parent().mode:
					"tag":
						isTagged = true
						$AudioStreamPlayer.play()
					"text":
						isImage = false
						$AudioStreamPlayer.play()


func _on_Area2D_mouse_entered():
	$ring.visible = true 


func _on_Area2D_mouse_exited():
	$ring.visible = false 
