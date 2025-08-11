extends "res://ex/chara/c1/c1.gd"

func _info():
	pass

func _extInit():
	._extInit()
	chaName = "弓箭手"
	attCoe.atkRan += 1
	lv = 2
	evos = ["c1_2_1", "c1_2_2"]
	atkEff = "atk_gongJian"
	addSkillTxt("普通攻击20%概率获得5层[急速]")
	

func _connect():
	._connect()
	
func _onAtkChara(atkInfo):
	._onAtkChara(atkInfo)
	if atkInfo.atkType == AtkType.NORMAL and sys.rndPer(20): addBuff(b_jiSu.new(5))
