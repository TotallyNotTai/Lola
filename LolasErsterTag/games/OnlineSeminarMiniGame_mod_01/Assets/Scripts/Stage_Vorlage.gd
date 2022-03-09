extends Node

onready var _animation_speechbubble = $Animation/Animate_dozent_speechbubble
onready var _animation_interference = $Animation/Animate_interference_speechbubble

export (ButtonGroup) var chat_selction_group

var _selected_answer_status : String = "wrong"

# main variable determinating the current stage
var _looping_stage_var : int = 0

# int determinating the correct button for solution
var _solution_var : int = 0

# dozent speechbubble
var _animation_dozent_status_str : String
# dozent speechbubble after solved issue
var _animation_dozent_solution_str : String
# outside inteference
var _animation_interference_str : String



func _ready():	
	# function setting text, animation and interference up
	_set_stage()
	
	# setting starting loop
	$Zoom_Background.texture = load("res://games/OnlineSeminarMiniGame_mod_01/Assets/Images/Prof_Sprites/template_background.png")
	$Dozent.texture = load("res://addons/dialogs/Images/portraits/Leo.png")
	$ChatArea.texture = load("res://games/OnlineSeminarMiniGame_mod_01/Assets/Images/temp_chat.png")
	
	# animating idle animation for lecturer and his speechbubble
	_animation_speechbubble.play(_animation_dozent_status_str)
	_animation_interference.play(_animation_interference_str)
	

	print(_selected_answer_status)
	
	

	# if player clicks on button and sends then dozent shall act upon it
	if _selected_answer_status == "wrong":
		for i in chat_selction_group.get_buttons():
			i.connect("pressed", self, "button_pressed")
	elif _selected_answer_status == "right":
		pass
	

func button_pressed():
	# do not delete the next line, otherwise sometimes a weird bug appears and dont assign the correct value to the solution
	print(str(_solution_var) + " solution_var")
	
	print(chat_selction_group.get_pressed_button())
	
	# set the number between 0 and 3 for selecting the right answer
	if chat_selction_group.get_pressed_button() == chat_selction_group.get_buttons()[_solution_var]:
		_selected_answer_status = "right"
		print(_selected_answer_status + " status")
	else:
		_selected_answer_status = "wrong"
		print(_selected_answer_status + " status")


# Player select answer, depending on answer do different things
func _on_Send_Button_pressed():
	if _selected_answer_status == "right":
		# right answer, disable all buttons, enable the next button
		print("right, sent")
		for i in chat_selction_group.get_buttons():
			i.disabled = true
		$Button/Send_Button.disabled = true
		$Button/Next_Button.disabled = false
		
		# change animation
		_animation_speechbubble.play(_animation_dozent_solution_str)
		_animation_interference.stop()
		
		# resetting stage in each specific loop
		if _looping_stage_var == 1:
			$Dozent.visible = true
			$Zoom_Background.texture = load("res://games/OnlineSeminarMiniGame_mod_01/Assets/Images/Prof_Sprites/template_background.png")
		elif _looping_stage_var == 2:
			$Interference_speechbubbles.visible = false
		elif _looping_stage_var == 3:
			$ChatArea.texture = load("res://games/OnlineSeminarMiniGame_mod_01/Assets/Images/temp_chat.png")
		
		
	elif _selected_answer_status == "wrong":
		# wrong answer
		print("wrong")


func _on_Next_Button_pressed():
	# enables all buttons and deselect the previous entry
	for i in chat_selction_group.get_buttons():
		i.disabled = false
		i.pressed = false
	
	$Button/Send_Button.disabled = false
	$Button/Next_Button.disabled = true
	
	# reset animation
	_animation_dozent_solution_str = ""
	_animation_dozent_status_str = ""
	_animation_interference_str = ""
	
	# moving to next set of problem
	_looping_stage_var += 1
	
	# build final loop checking + exiting game
	#asdf
	
	_ready()
	
# edit button text, edit animation, edit right solution with each loop
func _set_stage():
	var label_1 = $Button/Button_1/Label
	var label_2 = $Button/Button_2/Label
	var label_3 = $Button/Button_3/Label
	var label_4 = $Button/Button_4/Label
	
	if _looping_stage_var == 0:
		# muted speech
		label_1.text = "Wir können Sie nicht hören, \nkönnen Sie ihr Mikrofon einschalten?"
		label_2.text = "Laute Störlärm sind im Hintergrund zu hören, \nwir können Sie nicht verstehen."
		label_3.text = "Unser Bildschirm ist schwarz, \nhaben sie ihre Kamera richtig eingestellt?"
		label_4.text = "Wir können die hochgeladenen Dokumente nicht \nöffnen, können Sie nochmal da nach schauen?"
		
		_solution_var = 0
		print("solution var = " + str(_solution_var))
		
		# setting animation
		_animation_dozent_status_str = "muted_speech"
		_animation_dozent_solution_str = "solved_speech_muted"
		_animation_interference_str = "none"
	
	if _looping_stage_var == 1:
		# black screen
		$Dozent.visible = false
		
		label_1.text = ""
		label_2.text = ""
		label_3.text = ""
		label_4.text = "Unser Bildschirm ist schwarz, \nhaben sie ihre Kamera richtig eingestellt?"
		
		_solution_var = 3
		
		# setting animation
		_animation_dozent_status_str = "idle"
		_animation_dozent_solution_str = "solved_black_screen"
		_animation_interference_str = "black_screen"
		
		
	if _looping_stage_var == 2:
		# loud chatter
		$Interference_speechbubbles.visible = true
		
		label_1.text = ""
		label_2.text = ""
		label_3.text = "Alle reden wild durcheinander, \nkönnen Sie hier kurz um Ordnung sorgen? "
		label_4.text = ""

		_solution_var = 2

		# setting animation
		_animation_dozent_status_str = "idle"
		_animation_dozent_solution_str = "solved_loud_chaos"
		_animation_interference_str = "loud_chaos"

	if _looping_stage_var == 3:
		# missing documents
		label_1.text = "Wir können die hochgeladenen Dokumente nicht \nöffnen, können Sie nochmal darüber schauen? "
		label_2.text = ""
		label_3.text = ""
		label_4.text = ""

		_solution_var = 0

		# setting animation
		_animation_dozent_status_str = "document_load"
		_animation_dozent_solution_str = "document_solved"
		_animation_interference_str = "wrong_data"

		pass
		
# set template

#	if _looping_stage_var == 0:
#		label_1.text = ""
#		label_2.text = ""
#		label_3.text = ""
#		label_4.text = ""
#
#		_solution_var = 0
#
#		# setting animation
#		_animation_dozent_status_str = "idle"
#		_animation_dozent_solution_str = ""
#		_animation_interference_str = ""
#
