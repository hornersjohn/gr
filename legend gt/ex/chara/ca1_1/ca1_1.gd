extends "res://ex/chara/ca1/ca1.gd"


func _info():
	pass

func _extInit():
	._extInit()
	chaName = "哥布林战士"
	attCoe.atkRan = 1
	attCoe.maxHp = 6
	attCoe.def += 1
	attCoe.mgiDef += 1
	lv = 2
	evos = ["c8_1_1", "c8_1_2"]
	addCdSkill("10_1", 5)
	addSkillTxt("每5秒：对周围1格单位造成100%物理伤害")

func _connect():
	._connect()

func _castCdSkill(id):
	._castCdSkill(id)
	if id == "10_1":
		var chas = getCellChas(cell, 1)
		for i in chas:
			hurtChara(i, att.atk * 1, HurtType.PHY)
			
