extends Chara

func _info():
	pass

func _extInit():
	._extInit()
	chaName = "发芽种子"
	attCoe.atkRan = 1
	attCoe.maxHp = 3
	attCoe.atk = 3
	attCoe.mgiAtk = 3
	attCoe.def = 3
	attCoe.mgiDef = 3
	lv = 1
	evos = ["c7_1", "c7_2"]
	atkEff = "atk_dao"
	addCdSkill("c7", 4)
	addSkillTxt("每4秒发射一颗毒弹造成100%魔法伤害，并附加6层[中毒]")

func _connect():
	._connect()


func _castCdSkill(id):
	._castCdSkill(id)
	if id == "c7" and aiCha != null:
		var d: Eff = newEff("sk_feiDang", sprcPos)
		d._initFlyCha(aiCha)
		yield(d, "onReach")
		aiCha.addBuff(b_zhonDu.new(6))
		hurtChara(aiCha, att.mgiAtk * 1.0, Chara.HurtType.MGI)
	

			

