extends Item
	
func init():
	name = "荆棘盾"
	type = config.EQUITYPE_EQUI
	attInit()
	att.def = 80
	att.maxHp = 300
	info = "受到普通攻击，对攻击者造成15%物理防御的魔法伤害。"
	
func _connect():
	masCha.connect("onHurt", self, "run")

func run(atkInfo: AtkInfo):
	if atkInfo.atkType == Chara.AtkType.NORMAL:
		masCha.hurtChara(atkInfo.atkCha, masCha.att.def * 0.15, Chara.HurtType.MGI, Chara.AtkType.EFF)
