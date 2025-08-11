extends Chara

func _info():
	pass

func _extInit():
	._extInit()
	chaName = "男兵"
	attCoe.atkRan = 1
	attCoe.maxHp = 3
	attCoe.atk = 4
	attCoe.mgiAtk = 2
	attCoe.def = 3
	attCoe.mgiDef = 3
	lv = 1
	atkEff = "atk_dao"
	addCdSkill("5", 5)
	addSkillTxt("每5秒：获得5层[狂怒]")

func _connect():
	._connect()

func _castCdSkill(id):
	._castCdSkill(id)
	if id == "5":
		addBuff(b_kuangNu.new(5))
