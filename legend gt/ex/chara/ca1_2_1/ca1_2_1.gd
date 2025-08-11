extends "res://ex/chara/ca1_2/ca1_2.gd"

func _info():
	pass

func _extInit():
	._extInit()
	chaName = "哥布林双子"
	lv = 3
	addCdSkill("10_2_1", 5)
	addSkillTxt("每5秒：使最近3个友方生物获得5层[抵御][魔御]，并目标获得这两种buff层数的暴击率")

func _connect():
	._connect()

func _castCdSkill(id):
	._castCdSkill(id)
	if id == "10_2_1":
		var chas = getAllChas(2)
		chas.sort_custom(self, "sort")
		for i in range(3):
			if i >= chas.size(): break
			chas[i].addBuff(b_diYu.new(5))
			chas[i].addBuff(b_moYu.new(5))
			var n = 0
			var bf: Buff = chas[i].hasBuff("b_diYu")
			if bf != null:
				n += bf.life
			bf = chas[i].hasBuff("b_moYu")
			if bf != null:
				n += bf.life
			chas[i].addBuff(Bf.new(n))

func sort(a, b):
	if cellRan(a.cell, cell) < cellRan(b.cell, cell):
		return true
	return false

class Bf:
	extends Buff
	func _init(lv = 1):
		attInit()
		life = lv
		
	func init():
		pass
	
	func _connect():
		pass
		
	func _upS():
		att.cri = life * 0.01
