extends StaticBody3D

var bullet = preload("res://scenes/bullet.tscn")
var enemyBulletScene = preload("res://scenes/bulletEnemy.tscn")
var semiwall_scene = preload("res://scenes/semiwall.tscn")  # Replace with your actual scene path
var pillarwall_scene = preload("res://scenes/pillarwall.tscn")  # Replace with your actual scene path
var enemy_scene = preload("res://scenes/enemy.tscn")

var time_elapsed = 0.0

var enemyArray = []
var enemyIdArray = []


func _ready():
	call_deferred("post_ready")
	
	var new_enemy = enemy_scene.instantiate()
	add_child(new_enemy)
	new_enemy.global_transform.origin = global_transform.origin + Vector3(-2.5, 0.60, -5.5)
	new_enemy.scale = Vector3(0.60, 0.60, 0.60) 
	
	new_enemy = enemy_scene.instantiate()
	add_child(new_enemy)
	new_enemy.global_transform.origin = global_transform.origin + Vector3(-4.5, 0.60, -4.5)
	new_enemy.scale = Vector3(0.60, 0.60, 0.60) 
	
	new_enemy = enemy_scene.instantiate()
	add_child(new_enemy)
	new_enemy.global_transform.origin = global_transform.origin + Vector3(-4.5, 0.60, -6.5)
	new_enemy.scale = Vector3(0.60, 0.60, 0.60) 
	
	
	var new_child = semiwall_scene.instantiate()  # In Godot 3.x, use .instance()
	new_child.global_transform.origin = global_transform.origin + Vector3(-3.5, 0.20, -4.5)
	add_child(new_child)
	
	new_child = semiwall_scene.instantiate()
	new_child.global_transform.origin = global_transform.origin + Vector3(-1.5, 0.20, -4.5)
	add_child(new_child)
	
	var new_pillarWall = pillarwall_scene.instantiate()
	new_pillarWall.global_transform.origin = global_transform.origin + Vector3(-4.5, 0.20, -3.5)
	add_child(new_pillarWall)
	

func post_ready():
	var group_members = get_tree().get_nodes_in_group("enemyGroup")
	
	for member in group_members:
		print(member)
		enemyArray.append(member)
		enemyIdArray.append(member.id)
		break

	
func shoot():
	var b = bullet.instantiate()
	b.position = $Player.position + Vector3(0, 0.3, -0.5)
	add_child(b)

func _physics_process(delta):
	if Input.is_action_just_pressed("shoot"):
		shoot()
	
	time_elapsed += delta
	if time_elapsed >= 3.0:
		
		for enemy in enemyArray:
			print(enemy)
			var enemyBullet = enemyBulletScene.instantiate()
			enemyBullet.position = enemy.get_parent().position + Vector3(0, 0.3, 0.5)
			add_child(enemyBullet)
			time_elapsed = 0.0  # Reset timer
