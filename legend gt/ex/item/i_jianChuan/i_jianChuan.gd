extends Item
	
func init():
	name = "斩铁"
	type = config.EQUITYPE_EQUI
	attInit()
	att.atk = 70
	att.pen = 70
	att.cd = 0.3
	
func _connect():
	pass
