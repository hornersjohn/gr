extends "res://ex/chara/c4/c4.gd"

func _info():
	pass

func _extInit():
	._extInit()
	chaName = "莽牛"
	lv = 2
	attCoe.atk += 1
	attCoe.mgiDef += 1
	attCoe.maxHp += 2
	addSkillTxt("普通攻击时自身周围1格其他敌方单位造成50%的伤害，并赋予2层[流血]")

func _connect():
	._connect()

func _onAtkChara(atkInfo):
	._onAtkChara(atkInfo)
	if atkInfo.atkType == AtkType.NORMAL:
		var chas = getCellChas(cell, 1)
		for i in chas:
			if i != atkInfo.hitCha and i != self:
				hurtChara(i, att.atk * 0.5, HurtType.PHY)
				i.addBuff(b_liuXue.new(2))
