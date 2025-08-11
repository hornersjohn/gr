extends "res://ex/chara/c9/c9.gd"


func _info():
	pass

func _extInit():
	._extInit()
	chaName = "妖精"
	attCoe.atkRan = 3
	lv = 2
	addSkillTxt("普攻攻击附加1层[结霜][流血]")

func _connect():
	._connect()


func _onAtkChara(atkInfo: AtkInfo):
	._onAtkChara(atkInfo)
	if atkInfo.atkType == AtkType.NORMAL:
		atkInfo.hitCha.addBuff(b_jieShuang.new(1))
		atkInfo.hitCha.addBuff(b_liuXue.new(1))
