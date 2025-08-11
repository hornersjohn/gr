extends "res://ex/chara/c4_1/c4_1.gd"

func _info():
	pass

func _extInit():
	._extInit()
	chaName = "犀牛萨满"
	lv = 3
	attCoe.atkRan += 1
	atkEff = "atk_dang"
	addCdSkill("c4_1_2", 10)
	addSkillTxt("每10秒，恢复自身及生命值百分比最低的友方随从17%生命值。")

func _connect():
	._connect()

func _castCdSkill(id):
	._castCdSkill(id)
	if id == "c4_1_2":
		var cha = null
		var m = 10000
		var chas = getAllChas(2)
		for i in chas:
			if i.att.hp / i.att.maxHp < m:
				cha = i
				m = i.att.hp / i.att.maxHp
		if cha != null: cha.plusHp(cha.att.maxHp * 0.17)
		self.plusHp(self.att.maxHp * 0.17)








