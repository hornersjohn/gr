extends "res://ex/chara/c4_2/c4_2.gd"

func _info():
	pass

func _extInit():
	._extInit()
	chaName = "三头犬"
	lv = 3
	attCoe.atkRan += 1
	addSkillTxt("攻击[流血]单位时，获得[急速]和[狂怒]，层数等于目标身上[流血]层数")

func _connect():
	._connect()
	
func _onAtkChara(atkInfo):
	._onAtkChara(atkInfo)
	if atkInfo.atkType == AtkType.NORMAL:
		var bf = atkInfo.hitCha.hasBuff("b_liuXue")
		if bf != null:
			addBuff(b_jiSu.new(5)).life = bf.life
			addBuff(b_kuangNu.new(5)).life = bf.life
