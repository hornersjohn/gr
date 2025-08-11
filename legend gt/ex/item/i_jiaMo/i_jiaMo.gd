extends Item
	
func init():
	name = "道服"
	type = config.EQUITYPE_EQUI
	attInit()
	att.maxHp = 500
	att.mgiDef = 60
	info = "进入战斗和每10秒，免疫一次技能伤害。"
	
func _connect():
	masCha.connect("onHurt", self, "run")

var tm = 0
func _upS():
	if tm > 0:
		tm -= 1

func run(atkInfo: AtkInfo):
	if tm == 0 and atkInfo.atkType == Chara.AtkType.SKILL:
		atkInfo.hurtVal = 0
		tm = 10
