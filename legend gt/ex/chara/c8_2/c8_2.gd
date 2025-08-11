extends "res://ex/chara/c8/c8.gd"


func _info():
	pass

func _extInit():
	._extInit()
	chaName = "鳗蛇"
	attCoe.atkRan = 1
	attCoe.mgiDef += 1
	attCoe.maxHp += 1.5
	lv = 2
	addSkillTxt("减少20%的魔法伤害")

func _connect():
	._connect()

func _onHurt(atkInfo: AtkInfo):
	._onHurt(atkInfo)
	if atkInfo.hurtType == HurtType.MGI:
		atkInfo.hurtVal *= 0.8
