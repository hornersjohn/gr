extends "res://ex/chara/c9_2/c9_2.gd"

func _info():
	pass

func _extInit():
	._extInit()
	chaName = "血刃妖精"
	lv = 3
	addCdSkill("c9_2_2", 5)
	addSkillTxt("每5秒：本次战斗攻击力累积增加 所有敌方[流血]层数")

func _connect():
	._connect()
	
func _castCdSkill(id):
	._castCdSkill(id)
	if id == "c9_2_2":
		var chas = getAllChas(1)
		var n = 0
		for cha in chas:
			var bf: Buff = cha.hasBuff("b_liuXue")
			
			if bf != null:
				n += bf.life
				
		attAdd.atk += n * 1

func _onBattleStart():
	attAdd.atk = 0
	pass
