extends "res://ex/chara/ca2/ca2.gd"


func _info():
	pass

func _extInit():
	._extInit()
	chaName = "恶魔战士"
	attCoe.atkRan = 1
	attCoe.maxHp = 6
	attCoe.def += 1
	attCoe.mgiDef += 1
	lv = 2
	evos = ["c8_1_1", "c8_1_2"]
	attAdd.reHp = 0.4
	addSkillTxt("治疗效果提升40%")

func _connect():
	._connect()
