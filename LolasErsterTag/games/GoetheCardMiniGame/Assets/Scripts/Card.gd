extends Node2D

enum Mode {
	IDLE,
	ORIENTATION,
	INSERT,
	VALIDATE,
	PAUSE
}

enum Face {
	FRONT,
	BACK
}

enum Direction {
	LEFT = 0,
	TOP = 90,
	RIGHT = 180,
	DOWN = 270
	
}

onready var cardFace = Face.FRONT
onready var directionIterator = 0
onready var cardDirection

onready var state 
onready var foundMatch = false

onready var TweenNode = get_node("Tween")

onready var moving = true



func _ready():	
	
	if state == Mode.ORIENTATION || state == Mode.INSERT:
		var leftButton = get_tree().root.get_node("Main")
		var rightButton = get_tree().root.get_node("Main")
		var flipButton = get_tree().root.get_node("Main")
		var validateButton = get_tree().root.get_node("Main")
		leftButton.connect("leftClicked",self,"rotateLeft")
		rightButton.connect("rightClicked",self,"rotateRight")
		flipButton.connect("flipClicked",self,"flip")	
		validateButton.connect("validateClicked", self, "validate")
	
	if state == Mode.IDLE:	
		randomize()
		cardFace = Face.values()[stepify(rand_range(0,1),1)]
		randomize()
		directionIterator = stepify(rand_range(0,3),1)
		cardDirection = Direction.values()[directionIterator]
		cardDirectionUpdate()
		GlobalCard.wantedCardStatus = [Face.keys()[cardFace], Direction.keys()[directionIterator]]
		print(GlobalCard.wantedCardStatus)
	
	
func _process(delta):	
	match state:
		Mode.IDLE:
			pass
		
		Mode.ORIENTATION:
			get_tree().root.find_node("ButtonRotLeft", true,false).show()
			get_tree().root.find_node("ButtonRotRight", true,false).show()
			get_tree().root.find_node("ButtonFlip", true,false).show()
		
		Mode.INSERT:
			if moving:
				if position.x == 640:
					TweenNode.interpolate_property(self, "position", self.position, Vector2(position.x-200, position.y), 1.5, Tween.TRANS_LINEAR, Tween.EASE_OUT)
					TweenNode.start()	
				if position.x == 440:
					TweenNode.interpolate_property(self, "position", self.position, Vector2(position.x+400, position.y), 3, Tween.TRANS_LINEAR, Tween.EASE_OUT)
					TweenNode.start()	
				if position.x == 840:
					TweenNode.interpolate_property(self, "position", self.position, Vector2(position.x-400, position.y), 3, Tween.TRANS_LINEAR, Tween.EASE_OUT)
					TweenNode.start()					
				
		Mode.VALIDATE:
			if position == Vector2(640,370):
				if foundMatch:
					GlobalCard.totalCardsValidated += 1
					state = Mode.PAUSE
					GlobalCard.newGame = true
					print("KARTE VALIDIERT")
				else:
					GlobalCard.totalCardsNotValidated += 1
					state = Mode.PAUSE
					GlobalCard.newGame = true
					print("KARTE KONNTE NICHT VALIDIERT WERDEN")
							
		Mode.PAUSE:
			pass
			
		
	if rotation_degrees == 360 || rotation_degrees == -360:
			rotation_degrees = 0
						
	cardFaceUpdate()
	cardDirectionUpdate()
	
	if GlobalCard.wantedCardStatus == GlobalCard.currentCardStatus:		
		foundMatch = true
	else:
		foundMatch = false



func rotateLeft():
	if directionIterator == 0:
		directionIterator = 3
	else:
		directionIterator -= 1
	
	cardDirection = Direction.values()[directionIterator]	
	showCardInfo()

func rotateRight():
	
	if directionIterator == 3:
		directionIterator = 0
	else:
		directionIterator += 1
	
	cardDirection = Direction.values()[directionIterator]
	showCardInfo()	
	

func flip():
	if cardFace == Face.FRONT:
		cardFace = Face.BACK
	else:
		cardFace = Face.FRONT
	showCardInfo()
	
	
func validate():
	state = Mode.VALIDATE
	TweenNode.stop_all()
	TweenNode.interpolate_property(self, "position", self.position, Vector2(640, 370), 0.5, Tween.TRANS_LINEAR, Tween.EASE_OUT)
	TweenNode.start()
		

func cardFaceUpdate():	
	if cardFace == Face.FRONT:
		$CardFront.show()
		$CardBack.hide()
	else:
		$CardFront.hide()
		$CardBack.show()
		
		
func cardDirectionUpdate():		
	if cardDirection == Direction.LEFT:
		rotation_degrees = 0
	if cardDirection == Direction.TOP:
		rotation_degrees = 90
	if cardDirection == Direction.RIGHT:
		rotation_degrees = 180
	if cardDirection == Direction.DOWN:
		rotation_degrees = 270
		
		
func showCardInfo():	
	GlobalCard.currentCardStatus = [Face.keys()[cardFace], Direction.keys()[directionIterator]]
	print("Wanted: ", GlobalCard.wantedCardStatus)
	print("Current: ", GlobalCard.currentCardStatus)
	print("\n")


func _on_Timer_timeout():
	pass


func _on_Card_input_event(viewport, event, shape_idx):
	if event is InputEventMouse:
		if event.is_action_pressed("ui_mouseClick"):
			moving = false
			print("Card clicked")


func _on_Card_body_entered(body):
	if body.name == "Slot":
		pass
