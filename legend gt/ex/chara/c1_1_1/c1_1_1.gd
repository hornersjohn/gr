extends "res://ex/chara/c1_1/c1_1.gd"

func _info():
	pass

func _extInit():
	._extInit()
	chaName = "盾战士"
	lv = 3
	evos = []
	attAdd.dod = 0.3
	addSkillTxt("受到普通攻击时，30%概率格挡并反击对方(视为普通攻击)。")

func _connect():
	._connect()

func _onHurt(atkInfo: AtkInfo):
	._onHurt(atkInfo)
	if atkInfo.isMiss:
		normalAtkChara(atkInfo.atkCha)
