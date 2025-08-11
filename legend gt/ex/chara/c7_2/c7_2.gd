extends "res://ex/chara/c7/c7.gd"


func _info():
	pass

func _extInit():
	._extInit()
	chaName = "一棵草"
	attCoe.def += 1
	attCoe.mgiDef += 1
	attCoe.maxHp += 2
	lv = 2
	evos = ["c7_2_1", "c7_2_2"]
	addCdSkill("c7_2", 10)
	addSkillTxt("每10秒：恢复15%的生命值，我方单位释放技能时，减少4%冷却")

func _connect():
	._connect()
	
func _castCdSkill(id):
	._castCdSkill(id)
	if id == "c7_2":
		plusHp(att.maxHp * 0.15, true)

func _onCharaCastCdSkill(cha, id):
	._onCharaCastCdSkill(cha, id)
	if cha.team == self.team:
		var sk = getSkill("c7_2")
		sk.nowTime += sk.cd * 0.04
