extends Area3D

var bulletSpeed = 50

var initiated = true
var accuracyY = randf_range(-0.5, 0.5)
var accuracyX = randf_range(-0.5, 0.5)

@export var weaponDamage = 5

func _ready():
	connect("body_entered", _on_body_entered)
	connect("area_entered", _on_area_entered)
	print("Collision script is active.")

func _physics_process(delta):
	var direction = $bulletCollision.global_transform.origin
	direction.z -= 1
	
	if (initiated):
		direction.y += accuracyY
		direction.x += accuracyX
		initiated = false
	
	var directionTo = global_position.direction_to(direction)
	
	position += directionTo * bulletSpeed * delta
	
func _on_body_entered(body):
	print(body)
	queue_free()
	
func _on_area_entered(body):
	print(body)
	queue_free()
