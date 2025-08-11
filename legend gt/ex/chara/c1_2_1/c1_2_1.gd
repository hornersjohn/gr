extends "res://ex/chara/c1_2/c1_2.gd"

func _info():
	pass

func _extInit():
	._extInit()
	chaName = "游击者"
	attCoe.atkRan += 1
	lv = 3
	evos = []
	attAdd.cri += 0.5
	attAdd.criR += 0.2
	addSkillTxt("增加50%暴击,增加20%暴击伤害。")

func _connect():
	._connect()
