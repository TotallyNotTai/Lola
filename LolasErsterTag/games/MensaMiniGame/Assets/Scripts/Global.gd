extends Node

onready var timeForScreenChange = 5
onready var totalPoints = 0
onready var foodPoints = 0
onready var pointsToAchieveInLevel = 0

onready var showingTutorial = true
onready var gamePaused = true

var allFoods = []
onready var foodItems := {
	"Burger" : {
		"name": "Burger",
		"image" : "res://games/MensaMiniGame/Assets/Images/Food/Burger.png",
		"ingredients": ["Weizen", "Soja", "Milch"] 		
	},
	"Fish" : {
		"name": "Fisch (gebraten)",
		"image" : "res://games/MensaMiniGame/Assets/Images/Food/Fish.png",
		"ingredients": ["Fisch", "Sellerie", "Milch"] 		
	},
	"VegetableStew": {
		"name": "Gemüsepfanne",
		"image" : "res://games/MensaMiniGame/Assets/Images/Food/VegetableStew.png",
		"ingredients": ["Weizen"] 		
	},
	"HotDog": {
		"name": "Hotdog",
		"image" : "res://games/MensaMiniGame/Assets/Images/Food/Hotdog.png",
		"ingredients": ["Weizen", "Sellerie", "Senf"] 		
	},
	"Camembert": {
		"name": "Camembert",
		"image" : "res://games/MensaMiniGame/Assets/Images/Food/Camembert.png",
		"ingredients": ["Weizen", "Milch"] 		
	},
	"LenthilSoup": {
		"name": "Linseneintopf",
		"image" : "res://games/MensaMiniGame/Assets/Images/Food/LenthilSoup.png",
		"ingredients": ["Sellerie", "Schwefeldioxid"] 		
	},
	"Porridge": {
		"name": "Grießbrei",
		"image" : "res://games/MensaMiniGame/Assets/Images/Food/Porridge.png",
		"ingredients": ["Soja"] 		
	},
	"Steak": {
		"name": "Rindersteak",
		"image" : "res://games/MensaMiniGame/Assets/Images/Food/Steak.png",
		"ingredients": ["Weizen", "Ei"] 		
	},
	"Sausage": {
		"name": "Wurst",
		"image" : "res://games/MensaMiniGame/Assets/Images/Food/Wurst.png",
		"ingredients": ["Sellerie", "Senf"] 		
	}	
}

func _ready():
	getFoodInArray()

func _process(delta):
	pass

func setGameSpeed():	
	if totalPoints != 0 && timeForScreenChange > 1:
		if totalPoints % 2 == 0:
			timeForScreenChange -= 1
	
	if totalPoints != 0 && timeForScreenChange < 1 && timeForScreenChange >= 0.2 :
		if totalPoints % 2 == 0:
			timeForScreenChange -= 0.2
	
func getFoodInArray():
	randomize()
	allFoods.clear()
	for i in foodItems:
		allFoods.append(foodItems[i])

func resetPoints():
	pointsToAchieveInLevel = 0
	foodPoints = 0
