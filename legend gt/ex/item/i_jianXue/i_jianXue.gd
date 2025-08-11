extends Item
	
func init():
	name = "锯齿剑"
	type = config.EQUITYPE_EQUI
	attInit()
	att.atk = 80
	info = tr("普通攻击20%概率附加5层[流血]") + "\n" + tr("普通攻击流血单位时，会获得物理吸血： 层数*3%")
	
func _connect():
	masCha.connect("onAtkChara", self, "run")

func run(atkInfo: AtkInfo):
	if atkInfo.atkType == Chara.AtkType.NORMAL:
		if sys.rndPer(20): atkInfo.hitCha.addBuff(b_liuXue.new(5))
		var bf = atkInfo.hitCha.hasBuff("b_liuXue")
		if bf != null:
			att.suck = bf.life * 0.03
