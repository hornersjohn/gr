extends "res://ex/chara/c7_1/c7_1.gd"

func _info():
	pass

func _extInit():
	._extInit()
	chaName = "少女树"
	lv = 3
	attCoe.def += 1
	attCoe.mgiDef += 1
	attCoe.atkRan = 2
	attCoe.maxHp += 1
	addCdSkill("c7_1_2", 13)
	addSkillTxt("每13秒，召唤一颗人参果")

func _connect():
	._connect()

func _castCdSkill(id):
	._castCdSkill(id)
	if id == "c7_1_2":
		newChara("c7_1", self.cell)
