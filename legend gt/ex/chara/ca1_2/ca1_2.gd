extends "res://ex/chara/ca1/ca1.gd"


func _info():
	pass

func _extInit():
	._extInit()
	chaName = "哥布林法师"
	attCoe.atkRan = 3
	lv = 2
	addCdSkill("10_2", 3)
	addSkillTxt("每3秒：施放一个奥术飞弹造成100%法强的魔法伤害。")

func _connect():
	._connect()

func _castCdSkill(id):
	._castCdSkill(id)
	if id == "10_2" and aiCha != null:
		var d: Eff = newEff("sk_feiDang", sprcPos)
		d._initFlyCha(aiCha)
		yield(d, "onReach")
		hurtChara(aiCha, att.mgiAtk * 1, Chara.HurtType.MGI)
