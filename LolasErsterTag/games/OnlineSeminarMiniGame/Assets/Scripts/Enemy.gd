extends Node2D

signal connectToEnemy
signal playerAnimationSlash

onready var wordTiles

onready var enemyText

onready var stdCursor = load("res://games/OnlineSeminarMiniGame/Assets/Images/crosshair.png")
onready var fistCursor = load("res://games/OnlineSeminarMiniGame/Assets/Images/fist.png")

func _ready():
	$TimerToDestroy.wait_time = 1
	
func _process(delta):
	if position.distance_to(GlobalOnline.playerPosition) == 75:
		#GlobalOnline.playerSlashAnimation = true
		self.destroy()

func destroy():
	var roomNode = get_tree().root.get_node("Main/Room")
	var tempText = roomNode.showText
	var splitTextArray = tempText.rsplit(" ")
#	print("Array before: ",splitTextArray)
	randomize()
#	print("Array after: ",splitTextArray)
#	print("SIZE before: ",splitTextArray.size())
	splitTextArray.remove(rand_range(0,splitTextArray.size()))
	var text = ""
	for word in splitTextArray:
		text += str(word, " ")
		
	roomNode.showText = str(text).strip_edges()
	#print("SIZE after: ",splitTextArray.size())
	GlobalOnline.enemyClicked = null
	GlobalOnline.numberOfEnemiesToSpawn -= 1
	Input.set_custom_mouse_cursor(stdCursor)
	queue_free() 


func _on_Area2D_input_event(viewport, event, shape_idx):
	var distanceX = 75
	if event is InputEventMouse:
		if event.is_action_pressed("ui_mouseClick"):
			GlobalOnline.enemyClicked = self
			GlobalOnline.runTo = Vector2(position.x-distanceX, position.y)
#			if GlobalOnline.playerPosition.x < position.x:
#				GlobalOnline.runTo = Vector2(position.x-distanceX, position.y)
#			elif GlobalOnline.playerPosition.x > position.x:
#				GlobalOnline.runTo = Vector2(position.x+distanceX, position.y)
#			else:
#				GlobalOnline.runTo = Vector2(position.x-distanceX, position.y)
				
			GlobalOnline.startRunning = true
			GlobalOnline.clickedOnEnemy = true
			print("Distance: ",position.distance_to(GlobalOnline.playerPosition))
			


func _on_Area2D_body_entered(body):	
#	print("Enemy: ",name)
#	print("Enemy Z: ", self.z_index)
#	print("Body: ",body.name)
	#print("Distance: ",position.distance_to(GlobalOnline.playerPosition))
	if body.name == "Player":		
		pass
		#body.get_node("AnimatedSprite").play("slash")
#
#		if position.y < body.position.y:
#			z_index = body.z_index+1
#		else:
#			z_index = body.z_index-1
		
		


func _on_TimerToDestroy_timeout():
	pass
	


func _on_TimerTextShow_timeout():
	$TimerToDestroy.wait_time = 1/wordTiles.size()


func _on_Area2D_mouse_entered():	
	Input.set_custom_mouse_cursor(fistCursor)


func _on_Area2D_mouse_exited():
	Input.set_custom_mouse_cursor(stdCursor)
