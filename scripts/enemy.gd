extends Area3D

var MIN_DELAY = 1
var MAX_DELAY = 3

var id = randi_range(0, 1000)

var health = 10
var weaponDamage = 10
var fireRate = 60.0
var burstDelay = 3
var burstAmount = 8
var initialDelay = (randi() % MAX_DELAY) + MIN_DELAY

var time_elapsed = 0.0
var minuteInSeconds = 60.0

var curBullet = 1
var isDelay = false
var isInitialDelay = true

signal enemyShoot(id, dmg)

func setClass(enemyTypeInst):
	health = enemyTypeInst.health
	weaponDamage = enemyTypeInst.damage
	fireRate = enemyTypeInst.fireRate
	burstDelay = enemyTypeInst.burstDelay
	burstAmount = enemyTypeInst.burstAmount

func _ready():
	connect("area_entered", _on_area_entered)
	add_to_group("enemyGroup")

func _physics_process(delta):
	time_elapsed += delta
	if isInitialDelay == true:
		if time_elapsed > initialDelay:
			isInitialDelay = false
	else:
		if curBullet <= burstAmount and isDelay == false:
			var fireDelay = minuteInSeconds/fireRate
			if time_elapsed >= fireDelay:
					curBullet += 1
					time_elapsed = 0.0
					emit_signal("enemyShoot", id, weaponDamage)
		else:
			if time_elapsed >= burstDelay and isDelay == true:
				isDelay = false
				curBullet = 1
			elif isDelay == false:
				isDelay = true
	
func _on_area_entered(body):
	if ("weaponDamage" in body) :
		var damageReceived = body.weaponDamage
		if (health > damageReceived):
			health -= damageReceived
		else:
			var parent = get_parent().get_parent()
			parent.enemyMap.erase(id)
			GlobalMap.deletePos("enemy" + str(id))
			queue_free()
		
	
