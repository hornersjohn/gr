extends "res://ex/chara/c2/c2.gd"

func _info():
	pass

func _extInit():
	._extInit()
	chaName = "独眼章鱼"
	attCoe.atkRan += 1
	attCoe.maxHp += 1
	attCoe.atk += 1
	attCoe.mgiAtk += 1
	lv = 2
	evos = ["c2_2_1", "c2_2_2"]
	atkEff = "atk_dao"
	addSkillTxt("每3次普通攻击额外产生一次普通攻击")
	

func _connect():
	._connect()
	
var anum = 1
func _onAtkChara(atkInfo):
	._onAtkChara(atkInfo)
	if atkInfo.atkType == AtkType.NORMAL:
		anum += 1
		if anum > 3:
			anum = 0
			normalAtkChara(atkInfo.hitCha)
