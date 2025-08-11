extends "res://ex/chara/c9_1/c9_1.gd"

func _info():
	pass

func _extInit():
	._extInit()
	chaName = "火山岩"
	lv = 3
	
	addCdSkill("c9_1_1", 11)
	addSkillTxt("每11秒： 每有一个敌方[烧灼]单位，我方便有一个单位获得相同层数 [抵御][魔御]")

func _connect():
	._connect()


func _castCdSkill(id):
	._castCdSkill(id)
	if id == "c9_1_1":
		var chas = getAllChas(1)
		var bs = []
		for cha in chas:
			var bf: Buff = cha.hasBuff("b_shaoZhuo")
			if bf != null:
				bs.append(bf.life)
		chas = getAllChas(2)
		for i in range(bs.size()):
			if i < chas.size():
				chas[i].addBuff(b_diYu.new(bs[i]))
				chas[i].addBuff(b_moYu.new(bs[i]))
