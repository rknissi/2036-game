extends Object

class_name playerWeapon

var name: String
var species: String

func _init(n, s):
	name = n
	species = s

func speak():
	print("The", species, "named", name, "says hello!")
