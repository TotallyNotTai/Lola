extends Node2D


func _ready():
	pass

func _process(delta):
	match GlobalCard.wantedCardStatus[1]:
		"RIGHT":
			scale.x = 1.5
			$CollisionShape2D.scale.x = 1.5
		"LEFT":
			scale.x = 1.5
			$CollisionShape2D.scale.x = 1.5
		"TOP":
			scale.x = 1
			$CollisionShape2D.scale.x = 1
		"DOWN":
			scale.x = 1
			$CollisionShape2D.scale.x = 1
