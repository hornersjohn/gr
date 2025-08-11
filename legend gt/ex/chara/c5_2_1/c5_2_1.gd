extends "res://ex/chara/c5_2/c5_2.gd"

func _info():
	pass

func _extInit():
	._extInit()
	chaName = "忍者"
	lv = 3
	attAdd.dod += 0.4
	addSkillTxt("40%的概率闪避普通攻击,获得等同于闪避的暴击率")

func _connect():
	._connect()
	attAdd.cri = att.dod
	upAtt()
	
func _upS():
	attAdd.cri = att.dod
