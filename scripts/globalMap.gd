extends Node

var playerId = "player"

var occupied = {}

var minX = 0
var maxX = 4

var minZ = 0
var maxZ = 9

var minPlayerX = 0
var maxPlayerX = 4
var minPlayerZ = 0
var maxPlayerZ = 4

var minEnemyX = 0
var maxEnemyX = 4
var minEnemyZ = 5
var maxEnemyZ = 9


var target_positions = [
	[
		Vector3(-4.5, 0.200, -0.5),
		Vector3(-3.5, 0.200, -0.5),
		Vector3(-2.5, 0.200, -0.5),
		Vector3(-1.5, 0.200, -0.5),
		Vector3(-0.5, 0.200, -0.5)
	],
		[
		Vector3(-4.5, 0.200, -1.5),
		Vector3(-3.5, 0.200, -1.5),
		Vector3(-2.5, 0.200, -1.5),
		Vector3(-1.5, 0.200, -1.5),
		Vector3(-0.5, 0.200, -1.5)
	],
			[
		Vector3(-4.5, 0.200, -2.5),
		Vector3(-3.5, 0.200, -2.5),
		Vector3(-2.5, 0.200, -2.5),
		Vector3(-1.5, 0.200, -2.5),
		Vector3(-0.5, 0.200, -2.5)
	],
			[
		Vector3(-4.5, 0.200, -3.5),
		Vector3(-3.5, 0.200, -3.5),
		Vector3(-2.5, 0.200, -3.5),
		Vector3(-1.5, 0.200, -3.5),
		Vector3(-0.5, 0.200, -3.5)
	],
			[
		Vector3(-4.5, 0.200, -4.5),
		Vector3(-3.5, 0.200, -4.5),
		Vector3(-2.5, 0.200, -4.5),
		Vector3(-1.5, 0.200, -4.5),
		Vector3(-0.5, 0.200, -4.5)
	],
			[
		Vector3(-4.5, 0.200, -5.5),
		Vector3(-3.5, 0.200, -5.5),
		Vector3(-2.5, 0.200, -5.5),
		Vector3(-1.5, 0.200, -5.5),
		Vector3(-0.5, 0.200, -5.5)
	],
			[
		Vector3(-4.5, 0.200, -6.5),
		Vector3(-3.5, 0.200, -6.5),
		Vector3(-2.5, 0.200, -6.5),
		Vector3(-1.5, 0.200, -6.5),
		Vector3(-0.5, 0.200, -6.5)
	],
			[
		Vector3(-4.5, 0.200, -7.5),
		Vector3(-3.5, 0.200, -7.5),
		Vector3(-2.5, 0.200, -7.5),
		Vector3(-1.5, 0.200, -7.5),
		Vector3(-0.5, 0.200, -7.5)
	],
			[
		Vector3(-4.5, 0.200, -8.5),
		Vector3(-3.5, 0.200, -8.5),
		Vector3(-2.5, 0.200, -8.5),
		Vector3(-1.5, 0.200, -8.5),
		Vector3(-0.5, 0.200, -8.5)
	],
			[
		Vector3(-4.5, 0.200, -9.5),
		Vector3(-3.5, 0.200, -9.5),
		Vector3(-2.5, 0.200, -9.5),
		Vector3(-1.5, 0.200, -9.5),
		Vector3(-0.5, 0.200, -9.5)
	],
 ]

func checkPos(id, x, z):
	for value in occupied.values():
		if value[0] == x and value[1] == z:
			return false
	if id == playerId:
		if x >= minPlayerX and x <= maxPlayerX and z >= minPlayerZ and z <= maxPlayerZ:
			return true
	elif id.contains("enemy"):
		if x >= minEnemyX and x <= maxEnemyX and z >= minEnemyZ and z <= maxEnemyZ:
			return true
	else:
		return true
	
func movePos(id, x, z):
	if checkPos(id, x, z):
		occupied[id] = [x, z]
		return true
	return false

func deletePos(id):
	if id in occupied:
		occupied.erase(id)
		return true
	return false
	
