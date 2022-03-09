extends Actor




# Called when the node enters the scene tree for the first time.
func _ready():
	_velocity.x = -actor_speed.x


# kill enemy upon hit
func _on_Hitbox_Area_area_entered(area):
	$Collision_Shape.disabled = true
	queue_free()
