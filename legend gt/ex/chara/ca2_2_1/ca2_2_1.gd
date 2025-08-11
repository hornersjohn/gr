extends "res://ex/chara/ca2_2/ca2_2.gd"

func _info():
	pass

func _extInit():
	._extInit()
	chaName = "纯洁之牙"
	lv = 3
	addSkillTxt("造成伤害时，治疗我方最低生命值的单位，治疗值等于50%的伤害值")

func _connect():
	._connect()

func _onAtkChara(atkInfo: AtkInfo):
	._onAtkChara(atkInfo)
	var cha = null
	var m = 10000
	var chas = getAllChas(2)
	for i in chas:
		if i.att.hp / i.att.maxHp < m:
			cha = i
			m = i.att.hp / i.att.maxHp
	if cha != null: cha.plusHp(atkInfo.hurtVal * 0.5)
	
