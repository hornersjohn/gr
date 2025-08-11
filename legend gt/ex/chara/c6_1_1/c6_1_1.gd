extends "res://ex/chara/c6_1/c6_1.gd"

func _info():
	pass

func _extInit():
	._extInit()
	chaName = "四臂将军"
	lv = 3
	attCoe.def = 4
	addSkillTxt("每4次普通攻击:对周围1格敌方造成200%物理伤害，并附加[流血][中毒]各7层")

func _connect():
	._connect()

var anum = 1
func _onAtkChara(atkInfo):
	._onAtkChara(atkInfo)
	if atkInfo.atkType == AtkType.NORMAL:
		anum += 1
		if anum > 3:
			anum = 0
			var chas = getCellChas(cell, 1)
			for i in chas:
				hurtChara(i, att.atk * 2, HurtType.PHY)
				i.addBuff(b_liuXue.new(7))
				i.addBuff(b_zhonDu.new(7))

func _onBattleStart():
	._onBattleStart()
	anum = 0
	pass
