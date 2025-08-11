extends "res://ex/chara/c5/c5.gd"

func _info():
	pass

func _extInit():
	._extInit()
	chaName = "盾卫"
	lv = 2
	attCoe.def += 1
	attCoe.mgiDef += 1
	attCoe.maxHp += 2.5
	addCdSkill("5_1", 5)
	addSkillTxt("每5秒：最近3名内友军获得[抵御][魔御]各5层")

func _connect():
	._connect()

func _castCdSkill(id):
	._castCdSkill(id)
	if id == "5_1":
		var chas = getAllChas(2)
		chas.sort_custom(self, "sort")
		for i in range(3):
			if i >= chas.size(): break
			chas[i].addBuff(b_diYu.new(5))
			chas[i].addBuff(b_moYu.new(5))

func sort(a, b):
	if cellRan(a.cell, cell) < cellRan(b.cell, cell):
		return true
	return false
