extends "res://ex/chara/c3_1/c3_1.gd"

func _info():
	pass

func _extInit():
	._extInit()
	chaName = "圣剑天使"
	lv = 3
	attCoe.maxHp += 1
	attCoe.def += 2
	attCoe.atk += 2
	
	evos = []
	atkEff = "atk_dao"
	addCdSkill("c3_1_2", 5)
	addSkillTxt("每5秒：为最近6名友方单位祝福[狂怒][魔御]各10秒")

func _connect():
	._connect()

func _castCdSkill(id):
	._castCdSkill(id)
	if id == "c3_1_2":
		var chas = getAllChas(2)
		chas.sort_custom(self, "sort")
		for i in range(8):
			if i >= chas.size(): break
			chas[i].addBuff(b_kuangNu.new(6))
			chas[i].addBuff(b_moYu.new(6))

func sort(a, b):
	if cellRan(a.cell, cell) < cellRan(b.cell, cell):
		return true
	return false
