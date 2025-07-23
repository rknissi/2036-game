extends StaticBody3D

var bullet = preload("res://scenes/bullet.tscn")
var enemyBulletScene = preload("res://scenes/bulletEnemy.tscn")
var semiwall_scene = preload("res://scenes/semiwall.tscn")  # Replace with your actual scene path
var pillarwall_scene = preload("res://scenes/pillarwall.tscn")  # Replace with your actual scene path
var enemy_scene = preload("res://scenes/enemy.tscn")

var enemyMap = {}

func _ready():
	var emitter = get_node("Player")
	emitter.connect("game_over", self._on_game_over)
	
	spawnEnemy(0, 4)
	spawnEnemy(2, 5)
	
	spawnSemiWall(1, 4)
	spawnSemiWall(3, 4)
	spawnPillarWall(4, 3)
	
	call_deferred("post_ready")
	

func post_ready():
	var group_members = get_tree().get_nodes_in_group("enemyGroup")
	
	for member in group_members:
		enemyMap[member.id] = member

func shoot():
	var b = bullet.instantiate()
	b.position = $Player.position + Vector3(0, 0.3, -0.5)
	add_child(b)
	
func _on_game_over():
	$health.visible = false
	$gameOver.visible = true

func _physics_process(delta):
	$health/text.text = "Health: " + str($Player.health)
	
	if Input.is_action_just_pressed("shoot"):
		shoot()
			
func enemyShoot(id, dmg):
	print("Enemy shoot!")
	var enemy = enemyMap[id]
	var enemyBullet = enemyBulletScene.instantiate()
	enemyBullet.setDamage(dmg)
	enemyBullet.position = enemy.get_parent().position + Vector3(0, 0.3, 0.5)
	add_child(enemyBullet)
	
func spawnEnemy(x, z):
	var new_enemy = enemy_scene.instantiate()
	add_child(new_enemy)
	new_enemy.get_node("Area3D").connect("enemyShoot", self.enemyShoot)
	new_enemy.global_transform.origin = global_transform.origin + GlobalMap.target_positions[z][x] + Vector3(0, 0.4, 0) 
	GlobalMap.movePos("enemy" + str(new_enemy.get_node("Area3D").id), x, z)
	new_enemy.scale = Vector3(0.60, 0.60, 0.60) 
	
func spawnSemiWall(x, z):
	var new_child = semiwall_scene.instantiate()
	new_child.global_transform.origin = global_transform.origin + GlobalMap.target_positions[z][x]
	GlobalMap.movePos("semiWall" + str(new_child.id), x, z)
	add_child(new_child)
	
func spawnPillarWall(x, z):
	var new_pillarWall = pillarwall_scene.instantiate()
	new_pillarWall.global_transform.origin = global_transform.origin + GlobalMap.target_positions[z][x]
	GlobalMap.movePos("pillarWall" + str(new_pillarWall.id), x, z)
	add_child(new_pillarWall)
	
