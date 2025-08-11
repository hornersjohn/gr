extends Item
	
func init():
	name = "夜色匕首"
	type = config.EQUITYPE_EQUI
	attInit()
	att.spd = 0.6
	
	info = tr("普通攻击20%概率赋予5层[失明]") + "\n" + tr("普通攻击[失明]的生物，额外造成[失明]层数 * 5的魔法伤害")

func _connect():
	masCha.connect("onAtkChara", self, "run")

func run(atkInfo: AtkInfo):
	if atkInfo.atkType == Chara.AtkType.NORMAL:
		if sys.rndPer(20):
			atkInfo.hitCha.addBuff(b_shiMing.new(5))
		
		var bf: Buff = atkInfo.hitCha.hasBuff("b_shiMing")
		if bf != null:
			masCha.hurtChara(atkInfo.hitCha, bf.life * 5, Chara.HurtType.MGI, Chara.AtkType.EFF)
