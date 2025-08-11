extends Item
	
func init():
	name = "狂战斧"
	type = config.EQUITYPE_EQUI
	attInit()
	att.atk = 50
	att.spd = 0.3
	att.cri = 0.2
	att.atkR = 0.5
	att.defR = - 0.5
	info = "承受50%的额外伤害，获得50%的伤害加成"
