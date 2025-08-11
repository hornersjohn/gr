extends Chara

func _info():
	pass

func _extInit():
	._extInit()
	chaName = "小恶魔"
	attCoe.atkRan = 1
	attCoe.maxHp = 3
	attCoe.atk = 4
	attCoe.mgiAtk = 4
	attCoe.def = 3
	attCoe.mgiDef = 3
	lv = 1
	evos = ["c8_1", "c8_2"]
	atkEff = "atk_dao"
	attAdd.suck = 0.2
	attAdd.mgiSuck = 0.2
	addSkillTxt("获得20%双吸血 免疫[中毒]")

func _connect():
	._connect()

func _onAddBuff(buff: Buff):
	if buff is b_zhonDu:
		buff.isDel = true

