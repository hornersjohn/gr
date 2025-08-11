extends "res://ex/chara/ca2_2/ca2_2.gd"

func _info():
	pass

func _extInit():
	._extInit()
	chaName = "魅魔"
	lv = 3
	addSkillTxt("造成伤害时，附加[失明][结霜]各10层。")

func _connect():
	._connect()

func _onAtkChara(atkInfo: AtkInfo):
	._onAtkChara(atkInfo)
	atkInfo.hitCha.addBuff(b_shiMing.new(10))
	atkInfo.hitCha.addBuff(b_jieShuang.new(10))

