extends Item
	
func init():
	name = "神戒"
	type = config.EQUITYPE_EQUI
	attInit()
	att.suck = 0.2
	att.atk = 75

func _connect():
	pass

