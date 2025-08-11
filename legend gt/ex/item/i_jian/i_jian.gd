extends Item
	
func init():
	name = "细剑"
	type = config.EQUITYPE_EQUI
	attInit()
	att.atk = 20
	att.spd = 0.5
	info = "普通攻击额外造成目标最大生命值5%的物理伤害"
	
func _connect():
	masCha.connect("onAtkChara", self, "run")

func run(atkInfo: AtkInfo):
	if atkInfo.atkType == Chara.AtkType.NORMAL:
		masCha.hurtChara(atkInfo.hitCha, atkInfo.hitCha.att.maxHp * 0.05, Chara.HurtType.PHY, Chara.AtkType.EFF)
