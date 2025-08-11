extends Chara

func _info():
	pass

func _extInit():
	._extInit()
	chaName = "凤凰-传奇"
	lv = 4
	attCoe.atkRan = 3
	attCoe.maxHp = 7
	attCoe.atk = 6
	attCoe.mgiAtk = 6
	attCoe.def = 6
	attCoe.mgiDef = 6
	atkEff = "atk_dao"

	addSkillTxt("每11秒：所有敌方[烧灼]单位 附加相同层数的 [失明][中毒]")
	addCdSkill("c9_1_1", 11)
	addCdSkill("c9_1_2", 11)
	addCdSkill("c9_2_1", 11)
	addCdSkill("c9_2_2", 5)
	addSkillTxt("每11秒：驱散所有己方中毒，恢复0.5% * 敌方所有单位[中毒]总层数  的生命值。")
	addSkillTxt("每11秒：所有[结霜]的敌人受到150%法强的伤害，每1层[结霜]伤害提高4%")
	addSkillTxt("每5秒：本次战斗攻击力累积增加  所有敌方[流血]层数")
	addSkillTxt("普通攻击附加随机负面状态3层")

var baseId = ""


func _connect():
	._connect()
	
func _onBattleStart():
	attAdd.atk = 0
	pass


func _onAtkChara(atkInfo: AtkInfo):
	._onAtkChara(atkInfo)
	if atkInfo.atkType == AtkType.NORMAL:
		var bf = null
		var n = sys.rndRan(0, 3)
		if n == 0:
			bf = b_shaoZhuo.new(3)
		elif n == 1:
			bf = b_liuXue.new(3)
		elif n == 2:
			bf = b_jieShuang.new(3)
		else:
			bf = b_zhonDu.new(3)
		atkInfo.hitCha.addBuff(bf)


func _castCdSkill(id):
	._castCdSkill(id)
	if id == "c9_1_1":
		var chas = getAllChas(1)
		for cha in chas:
			var bf: Buff = cha.hasBuff("b_shaoZhuo")
			
			if bf != null:
				cha.addBuff(b_shiMing.new(bf.life))
				cha.addBuff(b_zhonDu.new(bf.life))
				var eff = newEff("huohua")
				eff.position = cha.position
	if id == "c9_1_2":
		var chas = getAllChas(0)
		var s = 0
		for cha in chas:
			var bf: Buff = cha.hasBuff("b_zhonDu")
			if bf != null:
				if cha.team == team:
					bf.att.reHp = 0.0
					bf.isDel = true
				else:
					s += bf.life
		upAtt()
		plusHp(s * att.maxHp * 0.005)
		
	if id == "c9_2_1":
		var chas = getAllChas(1)
		for cha in chas:
			var bf: Buff = cha.hasBuff("b_jieShuang")
			
			if bf != null:
				hurtChara(cha, att.mgiAtk * 1.5 * (1 + bf.life * 0.04), Chara.HurtType.MGI)
				
	if id == "c9_2_2":
		var chas = getAllChas(1)
		var n = 0
		for cha in chas:
			var bf: Buff = cha.hasBuff("b_liuXue")
			
			if bf != null:
				n += bf.life
				
		attAdd.atk += n * 1
