extends Object

class_name enemyType

var name: String
var health: int
var damage: int
var fireRate: float
var burstDelay: int
var burstAmount: int

func _init(n, h, d, f, bd, ba):
	name = n
	health = h
	damage = d
	fireRate = f
	burstDelay = bd
	burstAmount = ba
