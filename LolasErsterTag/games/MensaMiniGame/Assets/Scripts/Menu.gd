extends Node2D

onready var health = 3

var foodScene = load("res://games/MensaMiniGame/Assets/Scenes/Food.tscn")
onready var shouldCreateNewMenu = true
onready var foodPositionX = [256, 512, 768]
onready var foodPositionY = [280, 280, 280]

onready var allIngredients = []
onready var foundDuplicate = []
onready var allMenuItems = []
onready var allergen = ""
onready var menusCreated = false

onready var TweenNode = get_node("Tween")
onready var tweenSpeed = 1

onready var allFoodItems = []

onready var pointsMatch = false

signal showMenu
signal deleteFoodItems
signal gameOver

onready var gamedone = false
onready var menuNode = get_parent()

func _ready():
	menuNode.connect("gameover", self, "gameIsDone")

func _process(delta):
			
	if pointsMatch:
		$Screen.get_node("checkmark").show()
		$Timer.paused = false
		$Timer.wait_time = 2
		$Timer.start()	
		pointsMatch = false
	
	$PointsLabelText.text = GlobalMensa.totalPoints as String
	updateHealth()	
	sendAnimationStatusToFoodItems()
	
	if shouldCreateNewMenu:
		createNewMenu()
		showAllergie()	
		emit_signal("showMenu", allFoodItems)

func gameIsDone():
	gamedone = true	

func sendAnimationStatusToFoodItems():
	if menusCreated:
		if TweenNode.is_active():
			plateIsMoving(true)
		else:
			plateIsMoving(false)
	
func plateIsMoving(status):
	for food in allFoodItems:
		food.plateIsMoving = status

# Updates and showcases Health and its UI
func updateHealth():
	if health >= 3:
		$heartFull3.visible = true
	else:
		$heartFull3.visible = false
	
	if health >= 2:
		$heartFull2.visible = true
	else:
		$heartFull2.visible = false
	
	if health >= 1:
		$heartFull.visible = true
	else:
		$heartFull.visible = false	
		
	if health <= 0:
		emit_signal("gameOver")
	
	if $GameOverTimer.time_left == 0:
		$TimeLeftLabel.text = "0"
		emit_signal("gameOver")
	else:
		$TimeLeftLabel.text = str("Zeit übrig\n\n", stepify($GameOverTimer.time_left, 1))
	
	if gamedone:
		$TimeLeftLabel.text = str("Zeit übrig\n\n0")
		
		
	

# 3 Food Items are created and animated
# All Allergies are written down in an array
func createNewMenu():
	GlobalMensa.getFoodInArray()	
	allFoodItems.clear()
	allIngredients.clear()
	foundDuplicate.clear()
	
	var menuItemNames = ["menuItem1", "menuItem2", "menuItem3"]
	for i in menuItemNames.size():
		setUpMenu(menuItemNames[i], i)
	
	menusCreated = true
	shouldCreateNewMenu = false
	

# Menu is created and animation position are set here
func setUpMenu(menuItemName, itemNumber):
	var menu = foodScene.instance()
	menu.loadFood()
	menu.set_name(menuItemName)
	allFoodItems.append(menu)
	add_child(menu)	
	var startPosX = [1300, 1700, 2100]
	var endPosX = [256, 512, 768]
	var posY = 280
	var startPos
	var endPos
	match itemNumber:
		0:
			startPos = Vector2(startPosX[itemNumber], posY)
			endPos = Vector2(endPosX[itemNumber], posY)
		1:
			startPos = Vector2(startPosX[itemNumber], posY)
			endPos = Vector2(endPosX[itemNumber], posY)	
		2:
			startPos = Vector2(startPosX[itemNumber], posY)
			endPos = Vector2(endPosX[itemNumber], posY)	
			
	TweenNode.interpolate_property(menu, "position", startPos, endPos, tweenSpeed, Tween.TRANS_BACK, Tween.EASE_OUT)
	TweenNode.start()	
	for i in menu.currentFood["ingredients"]:		
		putInArray(i)
	allMenuItems.push_back(menu)

# Checks if the given text item is already in the Ingredients list 
# and put it in there only if text is not in the list
func putInArray(text):
	allIngredients.push_back(text)		

# Randomly chooses one allergie from the complete ingredients list
# and shows it
func showAllergie():
	for al in allIngredients:
		if allIngredients.count(al) == 1:
			allergen = al
	
	$AllergieLabel.text = "Sie haben folgende Allergie(n):\n\n" + allergen	

	for food in allFoodItems:
		var ingredients = food.currentFood["ingredients"]		
		if ingredients.has(allergen):
			food.edible = false			
		else:
			GlobalMensa.pointsToAchieveInLevel += 1
	

func levelFinished():
	emit_signal("deleteFoodItems")
	GlobalMensa.resetPoints()
#	for food in allFoodItems:
#		food.queue_free()
#	allFoodItems.clear()
	shouldCreateNewMenu = true
	

	
# Every food item will be destroyed and 3 new will be created
func _on_Timer_timeout():	
	$MenuDoneSound.play()
	levelFinished()
	$Timer.set_paused(true)	
	
func gameOver():
	get_tree().change_scene("res://scenes/Mensa02.tscn")


func _on_GameOverTimer_timeout():
	emit_signal("gameOver")
