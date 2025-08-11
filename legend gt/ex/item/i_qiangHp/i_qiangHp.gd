extends Item
	
func init():
	name = "生命之枪"
	type = config.EQUITYPE_EQUI
	attInit()
	att.maxHp = 500
	att.mgiDef = 60
	info = "战斗时获得相当于你最大生命值3%的攻击力"
	
func _connect():
	pass

func _upS():
	._upS()
	att.atk = masCha.att.maxHp * 0.03
