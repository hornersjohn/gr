extends Item
	
func init():
	name = "毒枪"
	type = config.EQUITYPE_EQUI
	attInit()
	att.atk = 60
	att.def = 60
	info = tr("普通攻击20%概率附加5层[中毒]") + "\n" + tr("普通攻击中毒单位时，恢复 层数 * 0.3%生命值")
	
func _connect():
	masCha.connect("onAtkChara", self, "run")

func run(atkInfo: AtkInfo):
	if atkInfo.atkType == Chara.AtkType.NORMAL:
		if sys.rndPer(20): atkInfo.hitCha.addBuff(b_zhonDu.new(5))
		var bf = atkInfo.hitCha.hasBuff("b_zhonDu")
		if bf != null:
			masCha.plusHp(bf.life * 0.003 * masCha.att.maxHp)
