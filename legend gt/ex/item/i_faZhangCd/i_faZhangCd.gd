extends Item
	
func init():
	name = "金法杖"
	type = config.EQUITYPE_EQUI
	attInit()
	att.mgiAtk = 110
	att.cd = 0.3

func _connect():
	pass

