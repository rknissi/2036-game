extends StaticBody3D

var bullet = preload("res://bullet.tscn")
var semiwall_scene = preload("res://semiwall.tscn")  # Replace with your actual scene path
var pillarwall_scene = preload("res://pillarwall.tscn")  # Replace with your actual scene path
var enemy_scene = preload("res://enemy.tscn")

func _ready():
	var new_child = semiwall_scene.instantiate()  # In Godot 3.x, use .instance()
	new_child.global_transform.origin = global_transform.origin + Vector3(-3.5, 0.20, -4.5)
	add_child(new_child)
	
	new_child = semiwall_scene.instantiate()
	new_child.global_transform.origin = global_transform.origin + Vector3(-1.5, 0.20, -4.5)
	add_child(new_child)
	
	var new_pillarWall = pillarwall_scene.instantiate()
	new_pillarWall.global_transform.origin = global_transform.origin + Vector3(-4.5, 0.20, -3.5)
	add_child(new_pillarWall)
	
	var new_enemy = enemy_scene.instantiate()

	new_enemy.global_transform.origin = global_transform.origin + Vector3(-2.5, 0.60, -5.5)
	new_enemy.scale = Vector3(0.60, 0.60, 0.60) 
	add_child(new_enemy)
	
func shoot():
	var b = bullet.instantiate()
	b.position = $Player.position + Vector3(0, 0.3, -0.5)
	add_child(b)

func _physics_process(delta):
	if Input.is_action_just_pressed("shoot"):
		shoot()
