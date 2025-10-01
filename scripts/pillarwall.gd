extends Area3D

var wallMaxHealth = 300
var wallCurrenthealth = wallMaxHealth
var id = randi_range(0, 1000)

signal spawnSemiWall
signal spawnDebrisBig
signal spawnDebrisSmall

func _ready():
	connect("area_entered", _on_area_entered)
	
func _on_area_entered(body):
	var direction = (body.global_transform.origin - global_transform.origin).normalized()
	if ("weaponDamage" in body) :
		var damageReceived = body.weaponDamage
		if (wallCurrenthealth > damageReceived):
			wallCurrenthealth -= damageReceived
		else:
			var currentPos = GlobalMap.getCurrentPos(GlobalMap.pillarWallId + str(id))
			if direction.z > 0:
				if GlobalMap.checkPos(GlobalMap.debrisBigId, currentPos.x, currentPos.y + 1):
					emit_signal("spawnDebrisBig", currentPos.x, currentPos.y + 1)
			elif direction.z < 0:
				if GlobalMap.checkPos(GlobalMap.debrisBigId, currentPos.x, currentPos.y - 1):
					emit_signal("spawnDebrisBig", currentPos.x, currentPos.y - 1)
			GlobalMap.deletePos(GlobalMap.pillarWallId + str(id))
			emit_signal("spawnSemiWall", currentPos.x, currentPos.y)
			emit_signal("spawnSemiDebrisSmall", currentPos.x, currentPos.y)
			queue_free()
			
