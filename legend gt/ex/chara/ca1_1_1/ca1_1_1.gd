extends "res://ex/chara/ca1_1/ca1_1.gd"

func _info():
	pass

func _extInit():
	._extInit()
	chaName = "莽夫哥布林"
	lv = 3
	
	addSkillTxt("普通攻击暴击时，释放第二个技能。")

func _connect():
	._connect()

func _onAtkChara(atkInfo: AtkInfo):
	._onAtkChara(atkInfo)
	if atkInfo.atkType == AtkType.NORMAL and atkInfo.isCri:
		_castCdSkill("10_1")
		emit_signal("onCastCdSkill", "10_1")
		sys.main.emit_signal("onCharaCastCdSkill", self, "10_1")
		_onCharaCastCdSkill(self, "10_1")
		newEff("xuLi2").setNorPos(sprcPos)
