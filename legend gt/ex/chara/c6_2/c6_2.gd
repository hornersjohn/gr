extends "res://ex/chara/c6/c6.gd"

func _info():
	pass

func _extInit():
	._extInit()
	chaName = "恶灵"
	lv = 2
	attCoe.def += 1
	attCoe.atk += 1
	attCoe.atkRan = 2
	atkEff = "atk_dang"
	addCdSkill("c6_2", 10)
	addSkillTxt("每10秒：召唤1个活尸,上限3只")


func _connect():
	._connect()

var num = 0

func _castCdSkill(id):
	._castCdSkill(id)
	if id == "c6_2" and num < 3:
		num += 1
		newChara("c6", self.cell)

func _onBattleStart():
	._onBattleStart()
	num = 0
	pass
