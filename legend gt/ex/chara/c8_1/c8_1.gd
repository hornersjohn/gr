extends "res://ex/chara/c8/c8.gd"


func _info():
	pass

func _extInit():
	._extInit()
	chaName = "幼龙"
	attCoe.atkRan = 3
	attCoe.maxHp = 3
	lv = 2
	evos = ["c8_1_1", "c8_1_2"]
	addSkillTxt("自身每一层[魔御]提高2%伤害输出，最高50%")

func _connect():
	._connect()

func _upS():
	._upS()
	var bf = hasBuff("b_moYu")
	if bf != null:
		attAdd.atkR = bf.life * 0.02
		upAtt()
