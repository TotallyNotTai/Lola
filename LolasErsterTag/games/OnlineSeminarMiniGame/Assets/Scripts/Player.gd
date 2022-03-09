extends Node2D

onready var TweenNode = get_node("Tween")
onready var target
onready var runningTime = 1
onready var movingToEnemy = false
var enemyNode = GlobalOnline.enemyClicked

func _ready():
	enemyNode = GlobalOnline.enemyClicked

func _process(delta):
	GlobalOnline.playerPosition = position
	
	if !$Tween.is_active():
		$AnimatedSprite.play("idle")
		
	if GlobalOnline.startRunning:
		var distance = position.distance_to(GlobalOnline.runTo)		
		runningTime = abs(distance*0.002)
		TweenNode.interpolate_property(self, "position", position, GlobalOnline.runTo, runningTime, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		if GlobalOnline.runTo.x < position.x:
			$AnimatedSprite.flip_h = true
		elif GlobalOnline.runTo.x > position.x:
			$AnimatedSprite.flip_h = false	
#		else:
#			$AnimatedSprite.flip_h = false
		
				
		if GlobalOnline.clickedOnEnemy == true:
			$AnimatedSprite.play("slash")
			$HitSound.play()
			GlobalOnline.clickedOnEnemy = false
		else:
			$AnimatedSprite.play("run")
		TweenNode.start()
		GlobalOnline.startRunning = false
	

func playSlashAnimation():
	print("PLAY SLASH")

