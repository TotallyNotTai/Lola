extends Node2D

onready var enemyScene = load("res://games/OnlineSeminarMiniGame/Assets/Scenes/Enemy.tscn")
onready var allEnemies = []

signal updateBoardText(value)


func _ready():
	$Timer.paused = true
	var enemySpawnerNode = get_parent()
	enemySpawnerNode.connect("createEnemies", self, "createEnemy")

func _process(delta):	
	if GlobalOnline.numberOfEnemiesToSpawn == 0:
		var doorNode = get_parent().get_node("Door")
		doorNode.get_node("CollisionShape2D").disabled = false		
		doorNode.show()
			

func createEnemy():
	for i in range(0,GlobalOnline.numberOfEnemiesToSpawn):
		randomize()
		var randomPositionX = rand_range(75,1000)	
		var randomPositionY = rand_range(200,600)
		var enemy = enemyScene.instance()
#		enemy.enemyText = GlobalOnline.allWordsInArray[i]
		enemy.position = Vector2(randomPositionX, randomPositionY)
		enemy.scale = Vector2(1,1)
		allEnemies.append(enemy)
		add_child(enemy)
	emit_signal("updateBoardText",allEnemies)	


func _on_Timer_timeout():	
	pass#get_tree().root.get_node("Main").createNewRoom()
