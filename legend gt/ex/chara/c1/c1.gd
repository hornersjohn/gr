extends Chara

func _info():
	pass

func _extInit():
	._extInit()
	chaName = "女兵"
	attCoe.atkRan = 1
	attCoe.maxHp = 3
	attCoe.atk = 4
	attCoe.mgiAtk = 2
	attCoe.def = 3
	attCoe.mgiDef = 3
	lv = 1
	evos = ["c1_1", "c1_2"]
	atkEff = "atk_dao"
	attAdd.spd += 0.3
	addSkillTxt("增加30%攻击速度")

func _connect():
	._connect()
