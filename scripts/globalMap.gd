extends Node

var playerId = "player"
var enemyDefaultId = "enemy"
var semiWalld = "semiWall"
var pillarWallId = "pillarWall"
var wallsDefaultId = "wall"
var debrisBigId = "debrisBig"
var debrisSmallId = "debrisSmall"

var playerDefaultX = 2
var playerDefaultZ = 0

var occupied = {}

var minX = 0
var maxX = 4

var minZ = 0
var maxZ = 9

var minPlayerX = minX
var maxPlayerX = maxX
var minPlayerZ = minZ
var maxPlayerZ = 4

var minEnemyX = minX
var maxEnemyX = maxX
var minEnemyZ = 5
var maxEnemyZ = maxZ


var target_positions = [
	[
		Vector3(-4.5, 0.050, -0.5),
		Vector3(-3.5, 0.050, -0.5),
		Vector3(-2.5, 0.050, -0.5),
		Vector3(-1.5, 0.050, -0.5),
		Vector3(-0.5, 0.050, -0.5)
	],
	[
		Vector3(-4.5, 0.050, -1.5),
		Vector3(-3.5, 0.050, -1.5),
		Vector3(-2.5, 0.050, -1.5),
		Vector3(-1.5, 0.050, -1.5),
		Vector3(-0.5, 0.050, -1.5)
	],
	[
		Vector3(-4.5, 0.050, -2.5),
		Vector3(-3.5, 0.050, -2.5),
		Vector3(-2.5, 0.050, -2.5),
		Vector3(-1.5, 0.050, -2.5),
		Vector3(-0.5, 0.050, -2.5)
	],
	[
		Vector3(-4.5, 0.050, -3.5),
		Vector3(-3.5, 0.050, -3.5),
		Vector3(-2.5, 0.050, -3.5),
		Vector3(-1.5, 0.050, -3.5),
		Vector3(-0.5, 0.050, -3.5)
	],
	[
		Vector3(-4.5, 0.050, -4.5),
		Vector3(-3.5, 0.050, -4.5),
		Vector3(-2.5, 0.050, -4.5),
		Vector3(-1.5, 0.050, -4.5),
		Vector3(-0.5, 0.050, -4.5)
	],
	[
		Vector3(-4.5, 0.050, -5.5),
		Vector3(-3.5, 0.050, -5.5),
		Vector3(-2.5, 0.050, -5.5),
		Vector3(-1.5, 0.050, -5.5),
		Vector3(-0.5, 0.050, -5.5)
	],
	[
		Vector3(-4.5, 0.050, -6.5),
		Vector3(-3.5, 0.050, -6.5),
		Vector3(-2.5, 0.050, -6.5),
		Vector3(-1.5, 0.050, -6.5),
		Vector3(-0.5, 0.0500, -6.5)
	],
	[
		Vector3(-4.5, 0.050, -7.5),
		Vector3(-3.5, 0.050, -7.5),
		Vector3(-2.5, 0.050, -7.5),
		Vector3(-1.5, 0.050, -7.5),
		Vector3(-0.5, 0.050, -7.5)
	],
[
		Vector3(-4.5, 0.050, -8.5),
		Vector3(-3.5, 0.050, -8.5),
		Vector3(-2.5, 0.050, -8.5),
		Vector3(-1.5, 0.050, -8.5),
		Vector3(-0.5, 0.050, -8.5)
	],
	[
		Vector3(-4.5, 0.050, -9.5),
		Vector3(-3.5, 0.050, -9.5),
		Vector3(-2.5, 0.050, -9.5),
		Vector3(-1.5, 0.050, -9.5),
		Vector3(-0.5, 0.050, -9.5)
	],
 ]

func checkIfCanSeePlayer(x, z):
	if occupied[playerId][0] != x:
		return false
	for key in occupied:
		if key != playerId and !key.contains(pillarWallId):
			if occupied[key][0] == x and z < occupied[key][1] and occupied[playerId][1] > occupied[key][1]:
				return false
	return true
	
func checkifHasType(type, x, z):
	for key in occupied:
		if key.contains(type) and occupied[key][0] == x and occupied[key][1] == z:
			return true
	return false
	
func getCurrentPos(id):
	if id in occupied:
		return Vector2(occupied[id][0], occupied[id][1])
	return null

func checkPos(id, x, z):
	for value in occupied.values():
		if value[0] == x and value[1] == z:
			return false
	if id == playerId:
		if x >= minPlayerX and x <= maxPlayerX and z >= minPlayerZ and z <= maxPlayerZ:
			return true
	elif id.contains(enemyDefaultId):
		if x >= minEnemyX and x <= maxEnemyX and z >= minEnemyZ and z <= maxEnemyZ:
			return true
	elif x >= minX and x <= maxX and z >= minZ and z <= maxZ:
		return true
	else:
		return false
	
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
	
