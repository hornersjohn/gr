extends "res://ex/chara/c9_2/c9_2.gd"

func _info():
	pass

func _extInit():
	._extInit()
	chaName = "雪女"
	lv = 3
	addCdSkill("c9_2_1", 11)
	addSkillTxt("每11秒：所有[结霜]的敌人受到150%法强的伤害，每1层[结霜]伤害提高4%")

func _connect():
	._connect()

func _castCdSkill(id):
	._castCdSkill(id)
	if id == "c9_2_1":
		var chas = getAllChas(1)
		for cha in chas:
			var bf: Buff = cha.hasBuff("b_jieShuang")
			
			if bf != null:
				hurtChara(cha, att.mgiAtk * 1.5 * (1 + bf.life * 0.04), Chara.HurtType.MGI)
