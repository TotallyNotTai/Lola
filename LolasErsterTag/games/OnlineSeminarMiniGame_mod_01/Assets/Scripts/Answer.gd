extends Node2D

var selected_state = false
var rest_point
var rest_nodes =  []

# create function to move sprite while holding it with the left mouse button (drag and drop)

func _ready():
	rest_nodes = get_tree().get_nodes_in_group("zone")
	rest_point = rest_nodes[0].global_position
	

# check if mouse enters CollisionShape and clicks, if so set variable selected_state to true
func _on_Area2D_input_event(viewport, event, shape_idx):
	if Input.is_action_pressed("ui_mouseClick"):
		selected_state = true

# if mouse clicks moves sprite to mouseposition
func _physics_process(delta):
	if selected_state:
		global_position = lerp(global_position, get_global_mouse_position(), 25 * delta)
	else:
		global_position = lerp(global_position, rest_point, 10 * delta)
		

# if mouse releases left button, release sprite
func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and not event.pressed:
			selected_state = false
			var shortest_dist = 75
			for child in rest_nodes:
				var distance = global_position.distance_to(child.global_position)
				if distance < shortest_dist:
					rest_point = child.global_position
					shortest_dist = distance
