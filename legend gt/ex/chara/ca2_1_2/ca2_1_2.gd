extends "res://ex/chara/ca2_1/ca2_1.gd"

func _info():
	pass

func _extInit():
	._extInit()
	chaName = "邪恶伯爵"
	lv = 3
	
	
	addSkillTxt("每有1%的物理吸血，提升1%的伤害。")

func _connect():
	._connect()

func _upS():
	attAdd.atkR = att.suck * 1
