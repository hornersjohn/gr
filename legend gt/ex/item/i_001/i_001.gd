extends Item
	
func init():
	name = "秘银肩甲"
	type = config.EQUITYPE_EQUI
	attInit()
	att.def = 40
	att.mgiDef = 40
	att.maxHp = 300
	info = "每损失1%的生命值 增加1%的免伤,最高50%。"
	

func _upS():
	._upS()
	var x = masCha.att.hp / masCha.att.maxHp
	if x > 0.5: x = 0.5
	att.defR = x
	
