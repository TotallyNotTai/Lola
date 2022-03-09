extends Node2D

onready var TweenNode = get_node("Tween")
onready var mode = get_parent().usingTool

signal showStatus
signal timesUp
signal newPaper
signal animatePaper

var languageDone = false
var titleTextDone = false
var startTextDone = false 
var fillableDone = false 
var midTextDone = false 
var endTextDone = false 
var isUnlocked = true
var deletePaper = false

func _ready():
	$PaperCreateSound.play()
	self.connect("timesUp", self, "destroy")
	self.connect("animatePaper", self, "moveDown")
	
	var mainNode = get_parent()
	mainNode.connect("validatePaper", self, "showValidation")
	TweenNode.interpolate_property(self, "position", self.position, Vector2(400, 24), 1, Tween.TRANS_BACK, Tween.EASE_OUT)
	TweenNode.start()	
	
func _process(delta):	
	mode = get_parent().usingTool
	
	
#		deletePaper = true
#		moveDown()
#		if deletePaper && !TweenNode.is_active():
#			destroy()
		#emit_signal("destroy")
		
		
func destroy():
	self.queue_free()	

func showValidation():
#	print("titleTextDone:", titleTextDone,"\n")
#	print("languageDone:", languageDone,"\n")
#	print("startTextDone:", startTextDone,"\n")
#	print("fillableDone:", fillableDone,"\n")
#	print("midTextDone:", midTextDone,"\n")
#	print("endTextDone:", endTextDone,"\n")
#	print("------------\n")
	emit_signal("showStatus")
	if titleTextDone && languageDone && startTextDone && fillableDone && midTextDone && endTextDone:
		$AudioStreamPlayer.play()
		$Timer.wait_time = 1.5
		$Timer.start()

func moveDown():
	TweenNode.interpolate_property(self, "position", self.position, Vector2(400, 725), 0.5, Tween.TRANS_BACK, Tween.EASE_OUT)
	TweenNode.start()	
	

func _on_Timer_timeout():
	get_parent().totalPapersDone += 1
	destroy()
