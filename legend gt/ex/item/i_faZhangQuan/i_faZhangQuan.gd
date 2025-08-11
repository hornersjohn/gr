extends Item
	
func init():
	name = "裁决"
	type = config.EQUITYPE_EQUI
	attInit()
	att.mgiAtk = 70
	att.atk = 50
	info = "每4次普通攻击额外造成100%物理伤害 和 100%魔法伤害"

func _connect():
	masCha.connect("onAtkChara", self, "run")
	anum = 0

var anum = 0
func run(atkInfo: AtkInfo):
	if atkInfo.atkType == Chara.AtkType.NORMAL:
		anum += 1
		if anum > 3:
			anum = 0
			masCha.hurtChara(atkInfo.hitCha, masCha.att.atk * 0.7, Chara.HurtType.PHY, Chara.AtkType.EFF)
			masCha.hurtChara(atkInfo.hitCha, masCha.att.mgiAtk * 0.7, Chara.HurtType.MGI, Chara.AtkType.EFF)
