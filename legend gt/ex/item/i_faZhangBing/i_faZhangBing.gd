extends Item
	
func init():
	name = "冰杖"
	type = config.EQUITYPE_EQUI
	attInit()
	att.mgiAtk = 110
	
	info = "技能命中敌方单位时，赋予目标5层[结霜]，并使目标承受结霜层数*3的真实伤害"

func _connect():
	masCha.connect("onAtkChara", self, "run")

func run(atkInfo: AtkInfo):
	if atkInfo.atkType == Chara.AtkType.SKILL and atkInfo.hurtType == Chara.HurtType.MGI:
		var bf = atkInfo.hitCha.addBuff(b_jieShuang.new(5))
		yield(sys.main.get_tree().create_timer(0.05), "timeout")
		atkInfo.atkCha.hurtChara(atkInfo.hitCha, bf.life * 3, Chara.HurtType.REAL, Chara.AtkType.EFF)
