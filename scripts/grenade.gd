extends Area3D

var grenadeSpeed = 10
var initialZ = 0

var weaponDamage = 300
var splashRadius = 2

func calculatePos(z):
	#y\ =-0.48x^{2}-2.4x
	return -2 * ((-0.96 * (z - initialZ)) - 2.4)

func _ready():
	connect("body_entered", _on_body_entered)
	connect("area_entered", _on_area_entered)

func _physics_process(delta):
	var direction = $grenadeCollision.global_transform.origin
	
	direction.z -= 10
	direction.y = calculatePos(position.z)
	
	var directionTo = global_position.direction_to(direction)
	
	position += directionTo * grenadeSpeed * delta
	
func _on_body_entered(body):
	queue_free()
	
func _on_area_entered(body):
	queue_free()
