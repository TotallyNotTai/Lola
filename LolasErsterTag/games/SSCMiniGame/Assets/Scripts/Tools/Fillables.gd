extends Node2D

var choice = [true, false]

var isTagged = false
var isImage = false
var isEditable = false


func _ready():
	var mainNode = get_parent()
	mainNode.connect("showStatus", self, "symbolActivation")
	
	choice.shuffle()
	isTagged = choice[0]
	choice.shuffle()
	isImage = choice[0]
	choice.shuffle()
	isEditable = choice[0]
	
	
func _process(delta):
	if isTagged == true && isImage == false && isEditable == true:
		get_parent().fillableDone = true
	
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
	
	match isEditable:
		true:
			$edit.visible = true
		false:
			$edit.visible = false

func symbolActivation():
	if get_parent().fillableDone:
		$cross.hide()
		$tick.show()
	else:
		$cross.show()
		$tick.hide()

func _on_Area2D_input_event(viewport, event, shape_idx):
	if event is InputEventMouse:
		if event.is_pressed():			
			match get_parent().mode:
				"edit":
					isEditable = true
					$AudioStreamPlayer.play()
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
