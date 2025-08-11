extends "res://ex/chara/c7/c7.gd"


func _info():
	pass

func _extInit():
	._extInit()
	chaName = "人参果"
	attCoe.atk = 3
	attCoe.mgiAtk = 3
	attCoe.maxHp += 1
	lv = 2
	evos = ["c7_1_1", "c7_1_2"]
	addCdSkill("c7_1", 2)
	addSkillTxt("每2秒：回复2格内友军2%的生命值。")

func _connect():
	._connect()
	
func _onDeath(atkInfo):
	._onDeath(atkInfo)

func _castCdSkill(id):
	._castCdSkill(id)
	if id == "c7_1":
		var chasSelfTeam = getCellChas(cell, 2, 2)
		for i in chasSelfTeam:
			i.plusHp(i.att.maxHp * 0.02)
