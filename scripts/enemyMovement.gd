extends CharacterBody3D

var id
var currentPosX
var currentPosZ
var targetPosX
var targetPosZ

var speed = 8
var fall_acceleration = 100

var time_elapsed = 0.0

#func _physics_process(delta):
	#time_elapsed += delta
	#print(targetPosX)
	#print(targetPosZ)
	#if 	targetPosX != null and targetPosZ != null && currentPosX != null and currentPosZ != null:		
		#print("if1")
		#if targetPosX != currentPosX or targetPosZ != currentPosZ:
			#print("if2")
			#if targetPosZ < GlobalMap.target_positions.size() && targetPosX < GlobalMap.target_positions[targetPosZ].size():
				#print("if3")
				#var target = GlobalMap.target_positions[targetPosZ][targetPosX]
				#var direction = (target - $PlayerPivot.global_transform.origin).normalized()
				#
				#velocity = direction * speed
				#move_and_slide()
