extends "res://ex/chara/c3_2/c3_2.gd"

func _info():
	pass

func _extInit():
	._extInit()
	chaName = "冰法师"
	attCoe.atkRan += 1
	lv = 3
	evos = []
	addCdSkill("c3_2_2", 10)
	addSkillTxt("每10秒：召唤冰雨连续4次对目标及2格内单位造成15%的魔法伤害，每次附加2[结霜]。")

func _connect():
	._connect()

func _castCdSkill(id):
	._castCdSkill(id)
	if id == "c3_2_2" and aiCha != null:
		var cell = aiCha.cell
		for i in range(4):
			var eff: Eff = newEff("sk_bingYu")
			eff.position = aiCha.position
			eff.scale *= 2
			yield(reTimer(0.5), "timeout")
			var chas = getCellChas(cell, 2)
			for j in chas:
				if j != null:
					hurtChara(j, att.mgiAtk * 0.15, HurtType.MGI)
					j.addBuff(b_jieShuang.new(2))
