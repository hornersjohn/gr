extends Item
	
func init():
	name = "火焰披风"
	type = config.EQUITYPE_EQUI
	attInit()
	att.maxHp = 500
	att.def = 60
	info = "每秒使周围1格敌方附加3层烧灼."
	
func _connect():
	pass

func _upS():
	var chas = masCha.getCellChas(masCha.cell, 1)
	for i in chas:
		i.addBuff(b_shaoZhuo.new(3))
