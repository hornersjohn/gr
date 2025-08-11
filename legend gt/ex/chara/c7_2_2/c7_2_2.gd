extends "res://ex/chara/c7_2/c7_2.gd"

func _info():
	pass

func _extInit():
	._extInit()
	chaName = "悲哀树精"
	lv = 3
	attCoe.maxHp += 0.5
	addCdSkill("c7_2_2", 10)
	addSkillTxt("每10秒：缠绕所有拥有负面buff的敌人，翻倍该负面buff的层数")

func _connect():
	._connect()

func _castCdSkill(id):
	._castCdSkill(id)
	if id == "c7_2_2":
		var chas = getAllChas(1)
		var sf
		for cha in chas:
			for bf in cha.buffs:
				if bf.isNegetive:
					sf = bf
					bf.life *= 2
			if sf != null:
				var eff = newEff("huohua")
				eff.position = cha.position
				

