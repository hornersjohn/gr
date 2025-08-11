extends Chara

func _info():
	pass

func _extInit():
	._extInit()
	chaName = "狼狗"
	attCoe.atkRan = 1
	attCoe.maxHp = 4
	attCoe.atk = 3
	attCoe.mgiAtk = 2
	attCoe.def = 3
	attCoe.mgiDef = 3
	lv = 1
	atkEff = "atk_dao"
	addSkillTxt("普通攻击使目标附加2层[流血]")

func _connect():
	._connect()

func _onAtkChara(atkInfo):
	._onAtkChara(atkInfo)
	if atkInfo.atkType == AtkType.NORMAL:
		atkInfo.hitCha.addBuff(b_liuXue.new(2))
