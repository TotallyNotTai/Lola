extends Node2D

var choice = [true, false]

var languageClear 

func _ready():
	var mainNode = get_parent()
	mainNode.connect("showStatus", self, "symbolActivation")
	choice.shuffle()
	languageClear = choice[0]
	
func _process(delta):
	if languageClear:
		get_parent().languageDone = true
		queue_free()
	else:
		$Unknown.show()

func symbolActivation():
	if languageClear:
		get_parent().languageDone = true
		$cross.hide()
		$tick.show()
	else:
		$cross.show()
		$tick.hide()

func _on_Area2D_input_event(viewport, event, shape_idx):
	if event is InputEventMouse:
		if event.is_pressed():
			match get_parent().mode:				
				"lang":
					$AudioStreamPlayer.play()
					languageClear = true
					get_parent().languageDone = true
					self.queue_free()
