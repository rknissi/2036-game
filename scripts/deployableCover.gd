extends Area3D

var wallMaxHealth = 1000
var wallCurrenthealth = wallMaxHealth
var id = randi_range(0, 1000)

func _ready():
	connect("area_entered", _on_area_entered)
	
func _on_area_entered(body):
	if ("weaponDamage" in body) :
		var damageReceived = body.weaponDamage
		if (wallCurrenthealth > damageReceived):
			wallCurrenthealth -= damageReceived
		else:
			GlobalMap.deletePos(GlobalMap.deployableCoverId + str(id))
			queue_free()
