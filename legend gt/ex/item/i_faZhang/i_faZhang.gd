extends Item
	
func init():
	name = "吸血杖"
	type = config.EQUITYPE_EQUI
	attInit()
	att.mgiAtk = 110
	att.mgiSuck = 0.3

func _connect():
	pass

