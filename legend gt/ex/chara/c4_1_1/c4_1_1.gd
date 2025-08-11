extends "res://ex/chara/c4_1/c4_1.gd"

func _info():
	pass

func _extInit():
	._extInit()
	chaName = "马头神使"
	lv = 3
	addCdSkill("c4_1_1", 7)
	addSkillTxt("每7秒，对3个法强最高敌方单位造成200%物理伤害，并附加10层[流血]")

func _connect():
	._connect()

func _castCdSkill(id):
	._castCdSkill(id)
	if id == "c4_1_1":
		var chas = getAllChas()
		chas.sort_custom(self, "sort")
		for i in range(3):
			if i >= chas.size(): break
			var cha: Chara = chas[i]
			fx(cha)

func sort(a, b):
	if a.att.mgiAtk > b.att.mgiAtk:
		return true
	return false

func fx(cha):
	var d: Eff = newEff("sk_4_1_2", sprcPos)
	d._initFlyCha(cha)
	yield(d, "onReach")
	if sys.isClass(cha, "Chara"):
		hurtChara(cha, att.atk * 2)
		cha.addBuff(b_liuXue.new(10))
