extends "res://ex/chara/c5_2/c5_2.gd"

func _info():
	pass

func _extInit():
	._extInit()
	chaName = "剑客"
	lv = 3
	attAdd.cri = 0.15
	addSkillTxt("+15%暴击，暴击时额外造成100%的物理伤害")

func _connect():
	._connect()

func _onAtkChara(atkInfo: AtkInfo):
	._onAtkChara(atkInfo)
	if atkInfo.isCri:
		hurtChara(atkInfo.hitCha, att.atk * 1)
