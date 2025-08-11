extends "res://ex/chara/c6_1/c6_1.gd"

func _info():
	pass

func _extInit():
	._extInit()
	chaName = "骷髅法师"
	lv = 3
	atkEff = "atk_dang"
	attCoe.atkRan = 3
	attCoe.mgiAtk += 1
	attCoe.mgiDef = 3
	attCoe.maxHp -= 1
	addCdSkill("c5_1_2", 2)
	addSkillTxt("每2秒：对1个敌方单位造成90%的魔法伤害，并附加[烧灼][中毒]各4层")

func _connect():
	._connect()
				
func _castCdSkill(id):
	._castCdSkill(id)
	if id == "c5_1_2" and aiCha != null:
		var d: Eff = newEff("sk_feiDang", sprcPos)
		d._initFlyCha(aiCha)
		yield(d, "onReach")
		hurtChara(aiCha, att.mgiAtk * 0.9, Chara.HurtType.MGI)
		aiCha.addBuff(b_zhonDu.new(4))
		aiCha.addBuff(b_shaoZhuo.new(4))
