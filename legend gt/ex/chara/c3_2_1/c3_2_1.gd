extends "res://ex/chara/c3_2/c3_2.gd"

func _info():
	pass

func _extInit():
	._extInit()
	chaName = "火法师"
	attCoe.atkRan += 1
	lv = 3
	evos = []
	addCdSkill("c3_2_1", 10)
	addSkillTxt("每10秒：召唤陨石对目标及1格内单位造成300%的魔法伤害,并附加10层[烧灼]")

func _connect():
	._connect()

func _castCdSkill(id):
	._castCdSkill(id)
	if id == "c3_2_1" and aiCha != null:
		var eff: Eff = newEff("sk_yunShi")
		eff.position = aiCha.position
		var chas = getCellChas(aiCha.cell, 1)
		yield(reTimer(0.45), "timeout")
		for i in chas:
			hurtChara(i, att.mgiAtk * 3.0, HurtType.MGI)
			i.addBuff(b_shaoZhuo.new(10))
