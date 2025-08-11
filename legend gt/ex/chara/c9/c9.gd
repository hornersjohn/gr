extends Chara

func _info():
	pass

func _extInit():
	._extInit()
	chaName = "小精灵"
	attCoe.atkRan = 1
	attCoe.maxHp = 3
	attCoe.atk = 4
	attCoe.mgiAtk = 4
	attCoe.def = 3
	attCoe.mgiDef = 3
	lv = 1
	evos = ["c8_1", "c8_2"]
	atkEff = "atk_dang"
	addSkillTxt("普通攻击20%概率附加随机负面状态5层")

func _connect():
	._connect()

func _onAtkChara(atkInfo: AtkInfo):
	._onAtkChara(atkInfo)
	if sys.rndPer(20) and atkInfo.atkType == AtkType.NORMAL:
		var bf = null
		var n = sys.rndRan(0, 3)
		if n == 0:
			bf = b_shaoZhuo.new(5)
		elif n == 1:
			bf = b_liuXue.new(5)
		elif n == 2:
			bf = b_jieShuang.new(5)
		else:
			bf = b_zhonDu.new(5)
		atkInfo.hitCha.addBuff(bf)
