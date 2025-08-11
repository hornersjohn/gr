extends "res://ex/chara/c3/c3.gd"

func _info():
	pass

func _extInit():
	._extInit()
	chaName = "圣职者"
	attCoe.def += 1
	attCoe.mgiDef += 2
	attCoe.maxHp += 2
	lv = 2
	evos = ["c3_1_1", "c3_1_2"]
	addCdSkill("c3_1", 9)
	addSkillTxt("每9秒：为生命最低的单位恢复50%法强生命值")

func _connect():
	._connect()

func _castCdSkill(id):
	._castCdSkill(id)
	if id == "c3_1":
		var cha = null
		var m = 10000
		var chas = getAllChas(2)
		for i in chas:
			if i.att.hp / i.att.maxHp < m:
				cha = i
				m = i.att.hp / i.att.maxHp
		if cha != null: cha.plusHp(att.mgiAtk * 0.5)
