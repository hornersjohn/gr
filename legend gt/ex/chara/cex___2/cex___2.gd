extends Chara

func _info():
	pass

func _extInit():
	._extInit()
	chaName = "奈亚拉托提普-传奇生物"
	lv = 4
	attCoe.atkRan = 1
	attCoe.maxHp = 8
	attCoe.atk = 6
	attCoe.mgiAtk = 6
	attCoe.def = 7
	attCoe.mgiDef = 4
	attAdd.defL += 0.4
	attAdd.suck += 0.4
	atkEff = "atk_dang"
	addCdSkill("c2_1_1", 10)
	addSkillTxt("每10秒：激光射线攻击直线单位造成200%的魔法伤害，并使其[失明]和[中毒]各7秒.")
	addSkillTxt("物理防御提高40%.")
	addSkillTxt("每3次普通攻击额外产生一次普通攻击")
	addSkillTxt("普攻附加50%物理防御的魔法伤害")
	
var baseId = ""


func _connect():
	._connect()

func _castCdSkill(id):
	._castCdSkill(id)
	if id == "c2_1_1":
		var eff: Eff = newEff("sk_jiGuan", sprcPos)

		eff.sprLookAt(aiCha.global_position)
		var chas = lineChas(cell, aiCha.cell, 4)
		for cha in chas:
			if cha.team != team:
				hurtChara(cha, att.mgiAtk * 2, Chara.HurtType.MGI)
				cha.addBuff(b_shiMing.new(7))
				cha.addBuff(b_zhonDu.new(7))

func lineChas(aCell, bCell, num):
	var chas = []
	var aPos = sys.main.map.map_to_world(aCell)
	var bPos = sys.main.map.map_to_world(bCell)
	var n = (bPos - aPos).normalized()
	var oldCell = null
	for i in range(num):
		aPos += n * 100
		var ac = sys.main.map.world_to_map(aPos)
		if oldCell != ac:
			oldCell = ac
			if matCha(ac) != null:
				chas.append(matCha(ac))
	return chas

func _onAtkChara(atkInfo: AtkInfo):
	._onAtkChara(atkInfo)
	
	if atkInfo.atkType == AtkType.NORMAL:
		anum += 1
		if anum > 3:
			anum = 0
			normalAtkChara(atkInfo.hitCha)
		hurtChara(atkInfo.hitCha, att.def * 0.5, Chara.HurtType.MGI, Chara.AtkType.EFF)
	
	
var anum = 1
