extends "res://ex/chara/c1/c1.gd"

func _info():
	pass

func _extInit():
	._extInit()
	chaName = "女战士"
	attCoe.def += 1
	attCoe.mgiDef += 1
	attCoe.maxHp += 2
	lv = 2
	evos = ["c1_1_1", "c1_1_2"]
	addSkillTxt("每次受到普通攻击增加一层[狂怒]。")

func _connect():
	._connect()

func _onHurt(atkInfo: AtkInfo):
	._onHurt(atkInfo)
	if atkInfo.atkType == AtkType.NORMAL:
		addBuff(b_kuangNu.new(1))
