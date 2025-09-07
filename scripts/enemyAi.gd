extends Node
class_name enemyAI

func moveToSamePlayerX(id):
	var currentPos = GlobalMap.getCurrentPos(id)
	if currentPos != null:
		var playerPos = GlobalMap.getCurrentPos(GlobalMap.playerId)
		if GlobalMap.checkPos(GlobalMap.enemyDefaultId, playerPos.x, currentPos.y):
			return true
	return false

func moveToNearestCover(id, fullCover):
	var currentPos = GlobalMap.getCurrentPos(id)
	if currentPos != null:
		var playerPos = GlobalMap.getCurrentPos(GlobalMap.playerId)
		if GlobalMap.checkPos(GlobalMap.enemyDefaultId, playerPos.x, currentPos.y):
			GlobalMap.movePos(id, currentPos.x, currentPos.y)
	return false
	
#func canMoveSide(id, curX, newX, z):
	#if newX == curX:
		#return true
	#if newX < curX
	#for column in range(GlobalMap.minEnemyX, GlobalMap.maxEnemyX):

#func checkForCoverInLine(x, z, fullCover):
	#for column in range(GlobalMap.minEnemyX, GlobalMap.maxEnemyX):
		#if GlobalMap.checkifHasType(GlobalMap.pillarWallId, column, z-1):
			#if 
