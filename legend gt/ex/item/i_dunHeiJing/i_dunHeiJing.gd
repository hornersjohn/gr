extends Item
	
func init():
	name = "黑晶盾"
	type = config.EQUITYPE_EQUI
	attInit()
	att.def = 60
	att.maxHp = 450
	info = "战斗时获得等同于物理抗性30%的魔抗"
	
func _connect():
	pass
	
func _upS():
	._upS()
	att.mgiDef = masCha.att.def * 0.3
