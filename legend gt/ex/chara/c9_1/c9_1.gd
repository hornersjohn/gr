extends "res://ex/chara/c9/c9.gd"


func _info():
	pass

func _extInit():
	._extInit()
	chaName = "元素"
	attCoe.atkRan = 1
	attCoe.maxHp = 6
	attCoe.def += 1
	attCoe.mgiDef += 1
	lv = 2
	evos = ["c8_1_1", "c8_1_2"]
	addSkillTxt("普攻攻击附加1层[烧灼][中毒]")

func _connect():
	._connect()

func _onAtkChara(atkInfo: AtkInfo):
	._onAtkChara(atkInfo)
	if atkInfo.atkType == AtkType.NORMAL:
		atkInfo.hitCha.addBuff(b_shaoZhuo.new(1))
		atkInfo.hitCha.addBuff(b_zhonDu.new(1))
