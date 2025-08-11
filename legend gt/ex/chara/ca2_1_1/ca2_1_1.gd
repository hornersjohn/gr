extends "res://ex/chara/ca2_1/ca2_1.gd"

func _info():
	pass

func _extInit():
	._extInit()
	chaName = "狂乱恶魔"
	lv = 3
	addCdSkill("a2_1", 5)
	addSkillTxt("每2秒,对最近单位造成100%的物理伤害，并额外发动1次普通攻击。")

func _connect():
	._connect()

func _castCdSkill(id):
	._castCdSkill(id)
	if id == "a2_1" and aiCha != null:
		normalAtkChara(aiCha)
		var d: Eff = newEff("sk_feiDang", sprcPos)
		d._initFlyCha(aiCha)
		yield(d, "onReach")
		hurtChara(aiCha, att.atk * 1, Chara.HurtType.PHY)
