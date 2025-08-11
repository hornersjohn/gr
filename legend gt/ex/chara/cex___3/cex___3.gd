extends Chara

func _info():
	pass

func _extInit():
	._extInit()
	chaName = "女神撒拉弗-传奇"
	lv = 4
	attCoe.atkRan = 3
	attCoe.maxHp = 5
	attCoe.atk = 5
	attCoe.mgiAtk = 7
	attCoe.def = 5
	attCoe.mgiDef = 6
	atkEff = "atk_dao"
	addCdSkill("c3_1_2", 5)
	addSkillTxt("每5秒：为最近8名友方单位祝福[狂怒][魔御]各10秒")
	addCdSkill("c3_1_2", 10)
	addSkillTxt("每10秒：为3个生命最低友方单位恢复50%法强生命值")
	addCdSkill("c3_2_1", 10)
	addSkillTxt("每10秒：召唤陨石对目标及1格内单位造成250%的魔法伤害,并附加10层[烧灼]")
	addCdSkill("c3_2_2", 10)
	addSkillTxt("每10秒：召唤冰雨连续4次对目标及2格内单位造成15%的魔法伤害，每次附加2[结霜]。")

var baseId = ""


func _connect():
	._connect()

func _castCdSkill(id):
	._castCdSkill(id)
	if id == "c3_1_2":
		var chas = getAllChas(2)
		chas.sort_custom(self, "sort")
		for i in range(8):
			if i >= chas.size(): break
			chas[i].addBuff(b_kuangNu.new(10))
			chas[i].addBuff(b_moYu.new(10))
			
	if id == "c3_1_2":
		var chas = getAllChas(2)
		chas.sort_custom(self, "sort2")
		for i in range(3):
			if i >= chas.size(): break
			chas[i].plusHp(att.mgiAtk * 0.5)
			
	if id == "c3_2_1" and aiCha != null:
		var eff: Eff = newEff("sk_yunShi")
		eff.position = aiCha.position
		var chas = getCellChas(aiCha.cell, 1)
		yield(reTimer(0.45), "timeout")
		for i in chas:
			hurtChara(i, att.mgiAtk * 2.5, HurtType.MGI)
			i.addBuff(b_shaoZhuo.new(10))
			
	if id == "c3_2_2" and aiCha != null:
		var cell = aiCha.cell
		for i in range(4):
			var eff: Eff = newEff("sk_bingYu")
			eff.position = aiCha.position
			eff.scale *= 2
			yield(reTimer(0.5), "timeout")
			var chas = getCellChas(cell, 2)
			for i in chas:
				if i != null:
					hurtChara(i, att.mgiAtk * 0.15, HurtType.MGI)
					i.addBuff(b_jieShuang.new(2))

func sort(a, b):
	if cellRan(a.cell, cell) < cellRan(b.cell, cell):
		return true
	return false
func sort2(a, b):
	if a.att.hp / a.att.maxHp < b.att.hp / b.att.maxHp:
		return true
	return false
