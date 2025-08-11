extends "res://ex/chara/c9_1/c9_1.gd"

func _info():
	pass

func _extInit():
	._extInit()
	chaName = "毒气团"
	lv = 3
	
	
	addCdSkill("c9_1_2", 11)
	addSkillTxt("每11秒：驱散所有己方中毒，恢复0.5% * 敌方所有单位[中毒]总层数  的生命值。")

func _connect():
	._connect()

func _onBattleStart():
	._onBattleStart()

func _castCdSkill(id):
	._castCdSkill(id)
	if id == "c9_1_2":
		var chas = getAllChas(0)
		var s = 0
		for cha in chas:
			var bf: Buff = cha.hasBuff("b_zhonDu")
			if bf != null:
				if cha.team == team:
					bf.att.reHp = 0.0
					bf.isDel = true
				else:
					s += bf.life
		upAtt()
		plusHp(s * att.maxHp * 0.005)
	
