extends Node2D

onready var menusToShow = []

onready var menuNode = get_parent()
onready var gameOver = false

func _ready():
	menuNode.connect("showMenu", self, "showMenuOnDisplay")
	$ScreenTextItemName.text = "NEU GERICHTE KOMMEN"
	$Timer.wait_time = GlobalMensa.timeForScreenChange
	
	
func _process(delta):
	$TimerShow.text = str(stepify($Timer.time_left, 1))
#	if GlobalMensa.gamePaused == false:
#		$Timer.set_paused(false)		
#	else:
#		$Timer.set_paused(true)
		

func showMenuOnDisplay(allMenuItems):
#	if GlobalMensa.gamePaused == false:
	$Timer.set_paused(false)
	$checkmark.hide()
	$TimerShow.hide()
	$ScreenTextItemName.text = "NEU GERICHTE KOMMEN"
	$ScreenTextAllergies.text = ""
	menusToShow = allMenuItems
	$Timer.wait_time = 2
	$Timer.start()
#	else:
#		$Timer.set_paused(true)	


func _on_Timer_timeout():
#	if GlobalMensa.gamePaused == false:
	if gameOver == false:
		$Timer.set_paused(false)	
		if menusToShow.size() == 0:
			$ScreenTextItemName.text = "Bitte wählen Sie die geeigneten Gerichte aus!"
			$ScreenTextAllergies.text = ""
			$TimerShow.hide()
		else:		
			#$TimerShow.show()
			var item = menusToShow.pop_front()
			$ScreenTextItemName.text = item.currentFood.name
			$ScreenTextAllergies.text = str("Allergene: ",item.currentFood["ingredients"])
			$Timer.wait_time = GlobalMensa.timeForScreenChange	
			$Timer.start()
	else:
		$ScreenTextItemName.text = "SPIEL VORBEI!"
		$ScreenTextAllergies.text = "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"
	
