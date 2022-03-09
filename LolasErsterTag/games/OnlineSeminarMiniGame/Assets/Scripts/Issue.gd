extends Node2D

onready var problemMode = true

func _ready():
	var enemySpawnerNode = get_parent().get_node("EnemySpawner")
	enemySpawnerNode.connect("updateBoardText", self, "updateText")
	
func _process(delta):
	if problemMode:
		$ProblemSprite.show()
		$SolutionSprite.hide()
	else:
		$ProblemSprite.hide()
		$SolutionSprite.show()

func updateText(enemiesList):
	$Problem.text = ""
	for enemy in enemiesList:
		$Problem.text = str($Problem.text , " " , enemy.enemyText)
		
