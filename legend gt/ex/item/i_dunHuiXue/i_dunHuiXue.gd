extends Item
	
func init():
	name = "环保盾"
	type = config.EQUITYPE_EQUI
	attInit()
	att.def = 20
	att.mgiDef = 70
	att.reHp = 0.3
	att.maxHp = 300
	
func _connect():
	pass

