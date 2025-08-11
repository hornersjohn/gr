extends Item
	
func init():
	name = "生命值服"
	type = config.EQUITYPE_EQUI
	attInit()
	att.maxHp = 800
	att.maxHpL = 0.2
	
func _connect():
	pass
