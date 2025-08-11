extends "res://ex/chara/c6_2/c6_2.gd"

func _info():
	pass

func _extInit():
	._extInit()
	chaName = "死灵术士"
	lv = 3
	addCdSkill("c6_2_2", 10)
	addSkillTxt("非召唤单位死亡：60%概率召唤一个活尸")

func _connect():
	._connect()

func _onCharaDel(cha):
	._onCharaDel(cha)
	if not cha.isSumm and isDeath == false and sys.rndPer(60):
		newChara("c6", cha.cell)
		
