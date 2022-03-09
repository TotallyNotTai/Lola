extends KinematicBody2D

class_name Actor

# Ensuring gravatation constantly pulls down on all actors (both player and enemies)


const FLOOR_NORMAL := Vector2.UP

export var actor_speed := Vector2(100.0, 100.0)
export var actor_gravity := 500.0

var _velocity := Vector2.ZERO

func _physics_process(delta):
	_velocity.y += actor_gravity * delta
