extends "res://ex/chara/c5_1/c5_1.gd"

func _info():
	pass

func _extInit():
	._extInit()
	chaName = "圣骑士"
	lv = 3
	addCdSkill("5_1_1", 10)
	addSkillTxt("每10秒：使友军的[抵御][魔御]层数翻倍")

func _connect():
	._connect()

func _castCdSkill(id):
	._castCdSkill(id)
	if id == "5_1_1":
		var bf1 = hasBuff("b_diYu")
		if bf1 != null:
			bf1.life *= 2
		var bf2 = hasBuff("b_moYu")
		if bf2 != null:
			bf2.life *= 2

