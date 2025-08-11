extends Chara

func _info():
	pass

func _extInit():
	._extInit()
	chaName = "爬行之卵"
	attCoe.atkRan = 1
	attCoe.maxHp = 3
	attCoe.atk = 3
	attCoe.mgiAtk = 4
	attCoe.def = 3
	attCoe.mgiDef = 4
	lv = 1
	evos = ["c8_1", "c8_2"]
	atkEff = "atk_dang"
	addCdSkill("c8", 5)
	addSkillTxt("每5秒：获得10层[魔御]")

func _connect():
	._connect()


func _castCdSkill(id):
	._castCdSkill(id)
	if id == "c8":
		addBuff(b_moYu.new(10))
	
