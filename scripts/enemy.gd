extends Area3D

var weaponDamage = 10
var fireDelay = 0.2
var health = 10
var id = randi_range(0, 1000)

var time_elapsed = 0.0

signal enemyShoot(id, dmg)

func _ready():
	connect("area_entered", _on_area_entered)
	add_to_group("enemyGroup")
	
func setWeaponDamage(dmg):
	weaponDamage = dmg

func setHealth(health):
	health = health
	
func setFireDelay(delay):
	fireDelay = delay
	
func _physics_process(delta):
	time_elapsed += delta
	if time_elapsed >= fireDelay:
			time_elapsed = 0.0
			emit_signal("enemyShoot", id, weaponDamage)
	
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
		
	
