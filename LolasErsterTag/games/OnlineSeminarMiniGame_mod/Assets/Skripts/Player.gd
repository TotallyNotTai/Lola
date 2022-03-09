extends Actor

# Define movement for player character
export (float) var player_speed = 2.0
export (float) var player_jump = 4.0
export (float) var max_fall_speed = 1000.0

var velocity = Vector2()
var _character_current_facing_direction = 1

onready var _character_sprite = $CharacterSprite
onready var _animation_player = $AnimationPlayer
onready var _hit_detector = $Hitdetector

# _physics_process(delta): for every frame it calculates the velocity of the character
func _physics_process(delta):
	var _direction = get_direction()
	var _character_status
	
	
	_velocity = velocity_calc(_velocity, _direction, actor_speed * player_speed)
	_velocity = move_and_slide(_velocity, FLOOR_NORMAL, true)
	if _velocity.y > max_fall_speed:
		_velocity.y = max_fall_speed
	
	# right animation to the right keybinding
	# direction.x == 1 : moving right,  direction.x == -1 : moving left
	# direction.y == -1 : jump
	
	# to get right character with right animation (no weird animation cancelling like midjump)
	# check character status
	if _direction.x == 1 and is_on_floor():
		_character_status = "walking right"

	elif _direction.x == -1 and is_on_floor():
		_character_status = "walking left"

	# for jump flip the character depending on left/right input and return to idle animation upon landing on floor
	elif Input.is_action_pressed("ui_up"):
		_character_status = "jumping"
		if is_on_floor():
			_character_status = "idle"

	# hit animation
	elif Input.is_action_pressed("ui_select"):
		_character_status = "attack"

	elif is_on_floor():
		_character_status = "idle"
	elif not is_on_floor():
		_character_status = "airborn"
	
	character_status_checker(_character_status)

# binding right animation with right status
func character_status_checker(character_status):
	if character_status == "walking right":
		_character_sprite.flip_h = false
		_animation_player.play("walk")
		hitbox_move(1)
	elif character_status == "walking left":
		_character_sprite.flip_h = true
		_animation_player.play("walk")
		hitbox_move(-1)
	elif character_status == "attack":
		_animation_player.play("hit")
	elif character_status == "idle":
		_animation_player.play("idle")
	elif character_status == "jumping":
		_animation_player.play("jump")
		character_status == "airborn"
	elif character_status == "airborn":
		_animation_player.play("jump")
		if Input.is_action_just_pressed("ui_right"):
			_character_sprite.flip_h = false
			hitbox_move(1)
		elif Input.is_action_just_pressed("ui_left"):
			_character_sprite.flip_h = true
			hitbox_move(-1)
		elif is_on_floor():
			character_status = "idle"
	
# move Hitdetector to the right side the player is facing
func hitbox_move(facing_direction):
	var new_facing = facing_direction
	if _character_current_facing_direction != new_facing:
		_hit_detector.position.x *= -1
		_character_current_facing_direction = new_facing


# get Player input depending on direction and only jump if player is on floor
func get_direction():
	return Vector2(Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left"),
	- Input.get_action_strength("ui_up") if Input.is_action_just_pressed("ui_up") and is_on_floor() else 0.0)


func velocity_calc(velocity:Vector2, direction:Vector2, speed):
	var output := velocity
	output.x = speed.x * direction.x
	if direction.y != 0.0:
		output.y = actor_speed.y * player_jump * direction.y
	return output

