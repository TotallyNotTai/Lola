extends Node2D

class_name Room

onready var updateText = false
onready var allWordsInArray = []
onready var splittedText
onready var showText 

signal createEnemies

func _ready():
	Input.set_custom_mouse_cursor(load("res://games/OnlineSeminarMiniGame/Assets/Images/crosshair.png"))
	self.name = "Room"
	var doorNode = get_node("Door")
	doorNode.connect("timeForNewRoom", self, "destroyRoom")
	
	showText = GlobalOnline.currentIssue["issue"]#GlobalOnline.textToShowcaseList.pop_front()
	print(showText)
	splittedText = showText.rsplit(" ")
	GlobalOnline.numberOfEnemiesToSpawn = splittedText.size()
	#GlobalOnline.allWordsInArray = splittedText
	var issueNode = get_node("Issue")
	issueNode.get_node("Problem").text = str(GlobalOnline.currentIssue["issue"])
	issueNode.get_node("ProblemSprite").texture = load(GlobalOnline.currentIssue["imageProblem"])
	issueNode.get_node("SolutionSprite").texture = load(GlobalOnline.currentIssue["imageSolution"])
	emit_signal("createEnemies")

func _process(delta):
	if GlobalOnline.numberOfEnemiesToSpawn == 0:
		$Issue.problemMode = false
		
	var issueNode = get_node("Issue")
	issueNode.get_node("Problem").text = showText
		
func destroyRoom():
	self.queue_free()
