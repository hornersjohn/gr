extends Item
	
func init():
	name = "残暴之剑"
	type = config.EQUITYPE_EQUI
	attInit()
	att.atk = 80
	att.cri = 0.25
	att.criR = 0.2
	
func _connect():
	pass
