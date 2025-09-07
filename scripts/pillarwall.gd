extends Area3D

var wallMaxHealth = 100
var wallCurrenthealth = wallMaxHealth
var id = randi_range(0, 1000)

signal spawnSemiWall

func _ready():
	connect("area_entered", _on_area_entered)
	
func _on_area_entered(body):
	if ("weaponDamage" in body) :
		var damageReceived = body.weaponDamage
		if (wallCurrenthealth > damageReceived):
			wallCurrenthealth -= damageReceived
		else:
			var currentPos = GlobalMap.getCurrentPos(GlobalMap.pillarWallId + str(id))
			GlobalMap.deletePos(GlobalMap.pillarWallId + str(id))
			emit_signal("spawnSemiWall", currentPos.x, currentPos.y)
			queue_free()
			
