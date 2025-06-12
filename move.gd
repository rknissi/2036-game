extends CharacterBody3D

#@export var bullet : PackedScene

# How fast the player moves in meters per second.
@export var speed = 5
# The downward acceleration when in the air, in meters per second squared.
@export var fall_acceleration = 100

var movementDelay = 0.3
var movementTimeElapsed = 0.0

var target_positions = [
	[
		Vector3(-4.5, 0.200, -0.5),
		Vector3(-3.5, 0.200, -0.5),
		Vector3(-2.5, 0.200, -0.5),
		Vector3(-1.5, 0.200, -0.5),
		Vector3(-0.5, 0.200, -0.5)
	],
		[
		Vector3(-4.5, 0.200, -1.5),
		Vector3(-3.5, 0.200, -1.5),
		Vector3(-2.5, 0.200, -1.5),
		Vector3(-1.5, 0.200, -1.5),
		Vector3(-0.5, 0.200, -1.5)
	],
			[
		Vector3(-4.5, 0.200, -2.5),
		Vector3(-3.5, 0.200, -2.5),
		Vector3(-2.5, 0.200, -2.5),
		Vector3(-1.5, 0.200, -2.5),
		Vector3(-0.5, 0.200, -2.5)
	],
			[
		Vector3(-4.5, 0.200, -3.5),
		Vector3(-3.5, 0.200, -3.5),
		Vector3(-2.5, 0.200, -3.5),
		Vector3(-1.5, 0.200, -3.5),
		Vector3(-0.5, 0.200, -3.5)
	],
			[
		Vector3(-4.5, 0.200, -4.5),
		Vector3(-3.5, 0.200, -4.5),
		Vector3(-2.5, 0.200, -4.5),
		Vector3(-1.5, 0.200, -4.5),
		Vector3(-0.5, 0.200, -4.5)
	],
			[
		Vector3(-4.5, 0.200, -5.5),
		Vector3(-3.5, 0.200, -5.5),
		Vector3(-2.5, 0.200, -5.5),
		Vector3(-1.5, 0.200, -5.5),
		Vector3(-0.5, 0.200, -5.5)
	],
			[
		Vector3(-4.5, 0.200, -6.5),
		Vector3(-3.5, 0.200, -6.5),
		Vector3(-2.5, 0.200, -6.5),
		Vector3(-1.5, 0.200, -6.5),
		Vector3(-0.5, 0.200, -6.5)
	],
			[
		Vector3(-4.5, 0.200, -7.5),
		Vector3(-3.5, 0.200, -7.5),
		Vector3(-2.5, 0.200, -7.5),
		Vector3(-1.5, 0.200, -7.5),
		Vector3(-0.5, 0.200, -7.5)
	],
			[
		Vector3(-4.5, 0.200, -8.5),
		Vector3(-3.5, 0.200, -8.5),
		Vector3(-2.5, 0.200, -8.5),
		Vector3(-1.5, 0.200, -8.5),
		Vector3(-0.5, 0.200, -8.5)
	],
			[
		Vector3(-4.5, 0.200, -9.5),
		Vector3(-3.5, 0.200, -9.5),
		Vector3(-2.5, 0.200, -9.5),
		Vector3(-1.5, 0.200, -9.5),
		Vector3(-0.5, 0.200, -9.5)
	],
 ]

var current_target_line = 0
var current_target_column = 2

var target_velocity = Vector3.ZERO

func _physics_process(delta):
		
	movementTimeElapsed += delta
	
	if Input.is_action_pressed("right") && current_target_column < 5 && movementTimeElapsed >= movementDelay:
		current_target_column += 1
		movementTimeElapsed = 0.0
	if Input.is_action_pressed("left") && current_target_column > 0 && movementTimeElapsed >= movementDelay:
		current_target_column -= 1
		movementTimeElapsed = 0.0
	if Input.is_action_pressed("down") && current_target_line > 0 && movementTimeElapsed >= movementDelay:
		current_target_line -= 1
		movementTimeElapsed = 0.0
	if Input.is_action_pressed("up") && current_target_line < 10 && movementTimeElapsed >= movementDelay:
		current_target_line += 1
		movementTimeElapsed = 0.0
	
	
	if current_target_line < target_positions.size() && current_target_column < target_positions[current_target_line].size():
		var target = target_positions[current_target_line][current_target_column]
		var direction = (target - $PlayerPivot.global_transform.origin).normalized()
		
		velocity = direction * speed
		move_and_slide()
