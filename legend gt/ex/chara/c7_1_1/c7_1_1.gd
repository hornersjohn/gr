extends "res://ex/chara/c7_1/c7_1.gd"

func _info():
	pass

func _extInit():
	._extInit()
	chaName = "食人花"
	lv = 3
	attCoe.atkRan = 3
	attCoe.atk += 1
	attCoe.maxHp = 3
	addSkillTxt("普攻附加2层[中毒]和[流血]，并造成[流血]+[中毒]层数*6的魔法伤害")

func _connect():
	._connect()
	
func _onAtkChara(atkInfo):
	._onAtkChara(atkInfo)
	if atkInfo.atkType == AtkType.NORMAL:
		atkInfo.hitCha.addBuff(b_zhonDu.new(2))
		atkInfo.hitCha.addBuff(b_liuXue.new(2))
		var s1 = 0
		var s2 = 0
		var duBuff = atkInfo.hitCha.hasBuff("b_zhonDu")
		if duBuff != null:
			s1 = duBuff.life
		var xueBuff = atkInfo.hitCha.hasBuff("b_liuXue")
		if xueBuff != null:
			s2 = xueBuff.life
		var s = (s1 + s2) * 6
		hurtChara(atkInfo.hitCha, s, HurtType.MGI, AtkType.EFF)
		
