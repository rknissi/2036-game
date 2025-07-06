extends Area3D

var wallMaxHealth = 10
var wallCurrenthealth = wallMaxHealth

func _ready():
	connect("area_entered", _on_area_entered)
	
func _on_area_entered(body):
	
	print("test")
	print(body)
	
	if ("weaponDamage" in body) :
		var damageReceived = body.weaponDamage
		if (wallCurrenthealth > damageReceived):
			wallCurrenthealth -= damageReceived
		else:
			queue_free()
			
#func _physics_process(delta):
		
	
