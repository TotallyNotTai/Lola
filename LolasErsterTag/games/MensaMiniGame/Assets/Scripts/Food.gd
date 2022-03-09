extends Node2D

var allFoods = []
var currentFood 
onready var TweenNode = get_node("Tween")

onready var placeToStop = Vector2(0,0)
onready var moveToTable = false

onready var plateIsMoving = false

onready var menuNode = get_tree().root.get_node("Main/Menu")

onready var edible = true

onready var alreadyClicked = false

signal pointsMatch

onready var connectedToMenu = false

func _ready():
	pass	

func _process(delta):
	menuNode = get_tree().root.get_node("Main/Menu")
	if connectedToMenu == false:
		menuNode.connect("deleteFoodItems", self, "destroy")
		connectedToMenu = true

func destroy():
	self.queue_free()

func loadFood():
	GlobalMensa.allFoods.shuffle()	
	currentFood = GlobalMensa.allFoods.pop_front()
	$FoodSprite.texture = load(currentFood.image)	
	$FoodLabel.text = currentFood.name	

# If clicked on Plate
func _on_Area2D_input_event(viewport, event, shape_idx):
	if event is InputEventMouse:
		if event.is_action_pressed("ui_mouseClick") && plateIsMoving == false && alreadyClicked == false:		
			$AudioStreamPlayer.play()	
			alreadyClicked = true
			if edible == false:
				menuNode.health -= 1
				$HealthGoneSound.play()
			else:
				GlobalMensa.totalPoints += 1
				GlobalMensa.foodPoints += 1
				GlobalMensa.setGameSpeed()
				if GlobalMensa.pointsToAchieveInLevel == GlobalMensa.foodPoints:
					get_parent().pointsMatch = true
			TweenNode.interpolate_property(self, "position", self.position, Vector2(position.x, position.y+200), 1, Tween.TRANS_BACK, Tween.EASE_OUT_IN)
			TweenNode.start()	
