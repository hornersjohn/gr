extends Chara

func _info():
	pass

func _extInit():
	._extInit()
	chaName = "修女"
	attCoe.atkRan = 2
	attCoe.maxHp = 2
	attCoe.atk = 3
	attCoe.mgiAtk = 4
	attCoe.def = 1
	attCoe.mgiDef = 2
	lv = 1
	evos = ["c3_1", "c3_2"]
	atkEff = "atk_dang"
	addCdSkill("c3", 3)
	addSkillTxt("每3秒：施放一个奥术飞弹造成100%法强的魔法伤害。")

func _connect():
	._connect()

func _castCdSkill(id):
	._castCdSkill(id)
	if id == "c3" and aiCha != null:
		var d: Eff = newEff("sk_feiDang", sprcPos)
		d._initFlyCha(aiCha)
		yield(d, "onReach")
		hurtChara(aiCha, att.mgiAtk * 1, Chara.HurtType.MGI)
