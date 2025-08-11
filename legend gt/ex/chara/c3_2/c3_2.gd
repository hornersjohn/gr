extends "res://ex/chara/c3/c3.gd"

func _info():
	pass

func _extInit():
	._extInit()
	chaName = "魔法师"
	attCoe.atkRan += 1
	lv = 2
	attCoe.maxHp += 1
	attCoe.def += 1
	attCoe.mgiDef += 1
	attAdd.mgiAtkL += 0.3
	evos = ["c3_2_1", "c3_2_2"]
	addSkillTxt("获得30%魔法强度")
	

func _connect():
	._connect()

