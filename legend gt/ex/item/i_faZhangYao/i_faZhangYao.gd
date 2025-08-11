extends Item
	
func init():
	name = "闪耀之杖"
	type = config.EQUITYPE_EQUI
	attInit()
	att.mgiAtk = 100
	att.cd = 0.2
	info = "释放技能时，下次普通攻击附加150%魔法伤害"

func _connect():
	masCha.connect("onCastCdSkill", self, "run1")
	masCha.connect("onAtkChara", self, "run2")
var bl = false
func run1(id):
	bl = true
	
func run2(atkInfo: AtkInfo):
	if bl and atkInfo.atkType == Chara.AtkType.NORMAL:
		masCha.hurtChara(atkInfo.hitCha, masCha.att.mgiAtk * 1.5, Chara.HurtType.MGI, Chara.AtkType.EFF)
		bl = false
