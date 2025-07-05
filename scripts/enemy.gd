extends Area3D

signal enemyRemoved(id)

var wallMaxHealth = 10
var wallCurrenthealth = wallMaxHealth
var id = randf_range(0, 1000)


func _ready():
	connect("area_entered", _on_area_entered)
	add_to_group("enemyGroup")
	
func _on_area_entered(body):
	
	if ("weaponDamage" in body) :
		var damageReceived = body.weaponDamage
		if (wallCurrenthealth > damageReceived):
			wallCurrenthealth -= damageReceived
		else:
			var parent = get_parent().get_parent()
			var pos = parent.enemyIdArray.find(id)
			parent.enemyIdArray.remove_at(pos)
			parent.enemyArray.remove_at(pos)
			queue_free()
		
	
