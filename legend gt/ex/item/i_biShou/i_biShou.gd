extends Item
	
func init():
	name = "高速匕首"
	type = config.EQUITYPE_EQUI
	attInit()
	att.spd = 0.6
	att.cri = 0.3

func _connect():
	pass

