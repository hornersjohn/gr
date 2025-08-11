extends "res://ex/chara/c3_1/c3_1.gd"

func _info():
	pass

func _extInit():
	._extInit()
	chaName = "天使长"
	lv = 3
	evos = []
	addCdSkill("c3_1_2", 10)
	addSkillTxt("每10秒：为3个生命最低友方单位恢复50%法强生命值")

func _connect():
	._connect()

func _castCdSkill(id):
	._castCdSkill(id)
	if id == "c3_1_2":
		var chas = getAllChas(2)
		chas.sort_custom(self, "sort")
		for i in range(3):
			if i >= chas.size(): break
			chas[i].plusHp(att.mgiAtk * 0.5)

func sort(a, b):
	if a.att.hp / a.att.maxHp < b.att.hp / b.att.maxHp:
		return true
	return false
	
