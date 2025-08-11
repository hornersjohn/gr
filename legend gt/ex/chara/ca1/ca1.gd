extends Chara

func _info():
	pass

func _extInit():
	._extInit()
	chaName = "哥布林"
	attCoe.atkRan = 1
	attCoe.maxHp = 3
	attCoe.atk = 4
	attCoe.mgiAtk = 4
	attCoe.def = 3
	attCoe.mgiDef = 3
	lv = 1
	evos = ["c8_1", "c8_2"]
	atkEff = "atk_dao"
	attAdd.cri = 0.2
	addSkillTxt("获得额外20%暴击率，并使cd技能也能够暴击")

func _connect():
	._connect()

func _onAtkInfo(atkInfo: AtkInfo):
	._onAtkInfo(atkInfo)
	if atkInfo.atkCha == self and atkInfo.atkType == AtkType.SKILL:
		atkInfo.canCri = true

