extends CharacterBody3D

@export var speed = 8
@export var fall_acceleration = 100
signal game_over
signal shoot
signal grenade_throw

var movementDelay = 0.1
var movementTimeElapsed = 0.0

var current_target_line = GlobalMap.playerDefaultZ
var current_target_column = GlobalMap.playerDefaultX

var target_velocity = Vector3.ZERO
var id = GlobalMap.playerId
var health = 100
var grenadeCount = 2

var curEquips = []

func _physics_process(delta):
	
	var oldColumn = current_target_column
	var oldLine = current_target_line
	if health <= 0:
		emit_signal("game_over")
		
	movementTimeElapsed += delta
	
	if Input.is_action_pressed("right") && current_target_column < GlobalMap.maxX && movementTimeElapsed >= movementDelay:
		current_target_column += 1
		movementTimeElapsed = 0.0
	if Input.is_action_pressed("left") && current_target_column > GlobalMap.minX && movementTimeElapsed >= movementDelay:
		current_target_column -= 1
		movementTimeElapsed = 0.0
	if Input.is_action_pressed("down") && current_target_line > GlobalMap.minZ && movementTimeElapsed >= movementDelay:
		current_target_line -= 1
		movementTimeElapsed = 0.0
	if Input.is_action_pressed("up") && current_target_line < GlobalMap.maxZ && movementTimeElapsed >= movementDelay:
		current_target_line += 1
		movementTimeElapsed = 0.0
	
	if GlobalMap.movePos(id, current_target_column, current_target_line):
		if current_target_line < GlobalMap.target_positions.size() && current_target_column < GlobalMap.target_positions[current_target_line].size():
			var target = GlobalMap.target_positions[current_target_line][current_target_column]
			var direction = (target - $PlayerPivot.global_transform.origin).normalized()
			
			velocity = direction * speed
			move_and_slide()
	elif velocity != Vector3.ZERO:
		var target = GlobalMap.target_positions[oldLine][oldColumn]
		var direction = (target - $PlayerPivot.global_transform.origin).normalized()
		
		velocity = direction * speed
		current_target_column = oldColumn
		current_target_line = oldLine
		move_and_slide()
	else:
		current_target_column = oldColumn
		current_target_line = oldLine
		
	if Input.is_action_just_pressed("shoot"):
		emit_signal("shoot")
		
	if Input.is_action_just_pressed("grenade") and grenadeCount > 0:
		grenadeCount -= 1
		emit_signal("grenade_throw")
	
