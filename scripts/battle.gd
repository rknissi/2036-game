extends StaticBody3D

var bullet = preload("res://scenes/bullet.tscn")
var grenade = preload("res://scenes/grenade.tscn")
var enemyBulletScene = preload("res://scenes/bulletEnemy.tscn")
var semiwall_scene = preload("res://scenes/semiwall.tscn")  # Replace with your actual scene path
var pillarwall_scene = preload("res://scenes/pillarwall.tscn")  # Replace with your actual scene path
var enemy_scene = preload("res://scenes/enemy.tscn")
var debrisBig_scene = preload("res://scenes/debrisBig.tscn")
var debrisSmall_scene = preload("res://scenes/debrisSmall.tscn")
var deployableCover_scene = preload("res://scenes/deployableCover.tscn")

var enemyTypes = {
	"PISTOL": enemyType.new(
		"PISTOL",
		90,
		30, 
		200.0,
		3,
		8
	),
	"SMG": enemyType.new(
		"SMG",
		90,
		20,
		900.0,
		3,
		15
	),"AR": enemyType.new(
		"AR",
		100,
		30,
		600.0,
		3,
		12
	),"MINIGUN": enemyType.new(
		"MINIGUN",
		300,
		34,
		900.0,
		2,
		100
	)}

var enemyTypeNames = enemyTypes.values().map(func(i): return i["name"])

var enemyMap = {}

var ENEMIES_MINIMUM = 2
var ENEMIES_MAXIMUM = 3
var ENEMIES_CLASSES = enemyTypeNames.size()

var PILLARS_MINIMUM = 1
var PILLARS_MAXIMUM = 4

var SEMIWALL_MINIMUM = 2
var SEMIWALL_MAXIMUM = 4


func _ready():
	var emitter = get_node("Player")
	emitter.connect("game_over", self._on_game_over)
	emitter.connect("shoot", self.shoot)
	emitter.connect("grenade_throw", self.grenadeThrow)
	emitter.connect("deploy_cover", self.spawnDeployableCover)
	
	addPlayerPos()
	generateEnemies()
	generatePillars()
	generateSemiWalls()
	
	call_deferred("post_ready")

func post_ready():
	var group_members = get_tree().get_nodes_in_group("enemyGroup")
	
	for member in group_members:
		enemyMap[member.id] = member

func shoot():
	var b = bullet.instantiate()
	b.position = $Player.position + Vector3(0, 0.3, -0.5)
	add_child(b)
	
func grenadeThrow():
	var g = grenade.instantiate()
	g.position = $Player.position + Vector3(0, 0.3, -0.5)
	g.initialZ = g.position.z
	add_child(g)
	
func _on_game_over():
	$health.visible = false
	$gameOver.visible = true
	GlobalMap.clearEverything()
	enemyMap.clear()

func _physics_process(delta):
	$health/text.text = "Health: " + str($Player.health)
			
func enemyShoot(id, dmg):
	if id in enemyMap:
		var enemy = enemyMap[id]
		var enemyBullet = enemyBulletScene.instantiate()
		enemyBullet.setDamage(dmg)
		enemyBullet.position = enemy.get_parent().position + Vector3(0, 0.3, 0.6)
		add_child(enemyBullet)

func addPlayerPos():
	GlobalMap.movePos(GlobalMap.playerId, GlobalMap.playerDefaultX, GlobalMap.playerDefaultZ)
	
func generatePillars():
	var quantity = randi() % (PILLARS_MAXIMUM - PILLARS_MINIMUM + 1) + PILLARS_MINIMUM
	
	for i in range(quantity):
		var validPos = false
		var pos
		
		while validPos == false:
			pos = generateRandonPos(GlobalMap.wallsDefaultId)
			validPos = GlobalMap.checkPos(GlobalMap.wallsDefaultId, pos.x, pos.y)
		
		spawnPillarWall(pos.x, pos.y)
		
func generateSemiWalls():
	var quantity = randi() % (SEMIWALL_MAXIMUM - SEMIWALL_MINIMUM + 1) + SEMIWALL_MINIMUM
	
	for i in range(quantity):
		var validPos = false
		var pos
		
		while validPos == false:
			pos = generateRandonPos(GlobalMap.wallsDefaultId)
			validPos = GlobalMap.checkPos(GlobalMap.wallsDefaultId, pos.x, pos.y)
		
		spawnSemiWall(pos.x, pos.y)
	
func generateEnemies():
	var quantity = randi() % (ENEMIES_MAXIMUM - ENEMIES_MINIMUM + 1) + ENEMIES_MINIMUM
	
	for i in range(quantity):
		var enemyClass = randi() % ENEMIES_CLASSES
		var validPos = false
		var pos
		
		while validPos == false:
			pos = generateRandonPos(GlobalMap.enemyDefaultId)
			validPos = GlobalMap.checkPos(GlobalMap.enemyDefaultId, pos.x, pos.y)
		
		spawnEnemy(pos.x, pos.y, enemyTypeNames[enemyClass])
	
func generateRandonPos(type):
	var x = randi() % GlobalMap.maxX + 1
	var z = 0
	if type == GlobalMap.playerId:
		z = randi() % GlobalMap.maxPlayerZ + 1
	elif type == GlobalMap.enemyDefaultId:
		z = randi() % (GlobalMap.maxEnemyZ - GlobalMap.minEnemyZ + 1) + GlobalMap.minEnemyZ
	else:
		z = randi() % GlobalMap.maxZ + 1
	return Vector2(x, z)
	
func checkVictory():
	if enemyMap.is_empty():
		$health.visible = false
		$victory.visible = true
		GlobalMap.clearEverything()
	
	
func spawnEnemy(x, z, enemyClass):
	var new_enemy = enemy_scene.instantiate()
	add_child(new_enemy)
	new_enemy.get_node("Area3D").connect("enemyShoot", self.enemyShoot)
	new_enemy.get_node("Area3D").connect("checkVictory", self.checkVictory)
	new_enemy.get_node("Area3D").setClass(enemyTypes[enemyClass])
	new_enemy.global_transform.origin = global_transform.origin + GlobalMap.target_positions[z][x] + Vector3(0, 0.5, 0) 
	GlobalMap.movePos("enemy" + str(new_enemy.get_node("Area3D").id), x, z)
	new_enemy.scale = Vector3(0.60, 0.60, 0.60) 
	new_enemy.get_node("Area3D").setPos(x, z)
	
func spawnDebrisBig(x, z):
	var new_child = debrisBig_scene.instantiate()
	new_child.global_transform.origin = global_transform.origin + GlobalMap.target_positions[z][x]
	GlobalMap.movePos(GlobalMap.debrisBigId + str(new_child.id), x, z)
	add_child(new_child)
	
func spawnDebrisSmall(x, z):
	var new_child = debrisSmall_scene.instantiate()
	new_child.global_transform.origin = global_transform.origin + GlobalMap.target_positions[z][x]
	add_child(new_child)
	
func spawnSemiWall(x, z):
	var new_child = semiwall_scene.instantiate()
	new_child.global_transform.origin = global_transform.origin + GlobalMap.target_positions[z][x]
	new_child.connect("spawnDebrisSmall", self.spawnDebrisSmall)
	GlobalMap.movePos(GlobalMap.semiWalld + str(new_child.id), x, z)
	add_child(new_child)
	
func spawnDeployableCover(x, z):
	var new_child = deployableCover_scene.instantiate()
	new_child.global_transform.origin = global_transform.origin + GlobalMap.target_positions[z][x]
	GlobalMap.movePos(GlobalMap.deployableCoverId + str(new_child.id), x, z)
	add_child(new_child)
	
func spawnPillarWall(x, z):
	var new_pillarWall = pillarwall_scene.instantiate()
	new_pillarWall.connect("spawnSemiWall", self.spawnSemiWall)
	new_pillarWall.connect("spawnDebrisBig", self.spawnDebrisBig)
	new_pillarWall.connect("spawnDebrisSmall", self.spawnDebrisSmall)
	new_pillarWall.global_transform.origin = global_transform.origin + GlobalMap.target_positions[z][x]
	GlobalMap.movePos(GlobalMap.pillarWallId + str(new_pillarWall.id), x, z)
	add_child(new_pillarWall)
	
func _on_retry_button_pressed():
	get_tree().change_scene_to_file("res://scenes/battle.tscn")
