extends Item
	
func init():
	name = "血精戒"
	type = config.EQUITYPE_EQUI
	attInit()
	att.suck = 0.2
	att.mgiSuck = 0.2
	att.atk = 50
	att.mgiAtk = 60

func _connect():
	pass

