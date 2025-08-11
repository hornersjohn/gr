extends "res://ex/chara/ca1_2/ca1_2.gd"

func _info():
	pass

func _extInit():
	._extInit()
	chaName = "火法哥布林"
	lv = 3
	addCdSkill("10_2_2", 7)
	addSkillTxt("每7秒：发射3枚火球，攻击最近的敌人，造成200%魔法伤害,并附加7层烧灼")

func _connect():
	._connect()
	
func _castCdSkill(id):
	._castCdSkill(id)
	if id == "10_2_2":
		var chas = getAllChas()
		chas.sort_custom(self, "sort")
		for i in range(3):
			if i >= chas.size(): break
			var cha: Chara = chas[i]
			fx(cha)

func sort(a, b):
	if cellRan(a.cell, cell) < cellRan(b.cell, cell):
		return true
	return false

func fx(cha):
	var d: Eff = newEff("sk_4_1_2", sprcPos)
	d._initFlyCha(cha)
	yield(d, "onReach")
	if sys.isClass(cha, "Chara"):
		hurtChara(cha, att.mgiAtk * 2, Chara.HurtType.MGI)
		cha.addBuff(b_shaoZhuo.new(7))
