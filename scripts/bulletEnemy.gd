extends Area3D

var bulletSpeed = 50

var accuracyY = randf_range(-0.1, 0.1)
var accuracyX = randf_range(-0.1, 0.1)

var weaponDamage = 50


func _ready():
	connect("body_entered", _on_body_entered)
	connect("area_entered", _on_area_entered)

func setDamage(dmg):
	weaponDamage = dmg

func _physics_process(delta):
	var direction = $bulletCollision.global_transform.origin
	
	direction.z += 1
	direction.y += accuracyY
	direction.x += accuracyX
	
	var directionTo = global_position.direction_to(direction)
	
	position += directionTo * bulletSpeed * delta
	
func _on_body_entered(body):
	if ("health" in body):
		body.health -= weaponDamage
	queue_free()
	
func _on_area_entered(body):
	queue_free()
