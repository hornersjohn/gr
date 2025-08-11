extends "res://ex/chara/c2_1/c2_1.gd"

func _info():
	pass

func _extInit():
	._extInit()
	chaName = "海螺章鱼"
	lv = 3
	evos = []
	attAdd.defL += 0.4
	attCoe.maxHp += 1
	addSkillTxt("物理防御提高40%.")

func _connect():
	._connect()
