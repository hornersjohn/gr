extends "res://ex/chara/c2_1/c2_1.gd"

func _info():
	pass

func _extInit():
	._extInit()
	chaName = "触手眼球"
	lv = 3
	attCoe.atkRan = 2
	attCoe.maxHp += 0.5
	evos = []
	addCdSkill("c2_1_1", 10)
	addSkillTxt("每10秒：激光射线攻击直线单位造成200%的魔法伤害，并使其[失明]和[中毒]各7秒.")

func _connect():
	._connect()

func _castCdSkill(id):
	._castCdSkill(id)
	if id == "c2_1_1":
		var eff: Eff = newEff("sk_jiGuan", sprcPos)

		eff.sprLookAt(aiCha.global_position)
		var chas = lineChas(cell, aiCha.cell, 4)
		for cha in chas:
			if cha.team != team:
				hurtChara(cha, att.mgiAtk * 2, Chara.HurtType.MGI)
				cha.addBuff(b_shiMing.new(7))
				cha.addBuff(b_zhonDu.new(7))

func lineChas(aCell, bCell, num):
	var chas = []
	var aPos = sys.main.map.map_to_world(aCell)
	var bPos = sys.main.map.map_to_world(bCell)
	var n = (bPos - aPos).normalized()
	var oldCell = null
	for i in range(num):
		aPos += n * 100
		var ac = sys.main.map.world_to_map(aPos)
		if oldCell != ac:
			oldCell = ac
			if matCha(ac) != null:
				chas.append(matCha(ac))
	return chas
