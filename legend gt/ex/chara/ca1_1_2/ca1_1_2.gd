extends "res://ex/chara/ca1_1/ca1_1.gd"

func _info():
	pass

func _extInit():
	._extInit()
	chaName = "绿皮哥布林"
	lv = 3
	
	
	addSkillTxt("暴击时，回复该次伤害的生命值。")

func _connect():
	._connect()

func _onAtkChara(atkInfo: AtkInfo):
	._onAtkChara(atkInfo)
	if atkInfo.isCri:
		plusHp(atkInfo.hurtVal)
