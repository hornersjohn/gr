extends "res://ex/chara/c2_2/c2_2.gd"

func _info():
	pass

func _extInit():
	._extInit()
	chaName = "触手法师"
	attCoe.atkRan += 1
	lv = 3
	evos = []
	addSkillTxt("普攻附加100%魔法伤害")

func _connect():
	._connect()

func _onAtkChara(atkInfo: AtkInfo):
	._onAtkChara(atkInfo)
	if atkInfo.atkType == AtkType.NORMAL: hurtChara(atkInfo.hitCha, att.mgiAtk * 1.0, Chara.HurtType.MGI, Chara.AtkType.EFF)
