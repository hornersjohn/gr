extends "res://ex/chara/c1_1/c1_1.gd"

func _info():
	pass

func _extInit():
	._extInit()
	chaName = "狂战士"
	lv = 3
	evos = []
	addSkillTxt("每损失1%的生命值，获得1%的攻速和攻击力！")

func _connect():
	._connect()

func _onHurt(atkInfo: AtkInfo):
	._onHurt(atkInfo)
	attAdd.spd = 0.3 + (1.0 - att.hp / att.maxHp)
	attAdd.atkL = 1.0 - (att.hp / att.maxHp)
