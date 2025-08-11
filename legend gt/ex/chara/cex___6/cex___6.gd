extends Chara

func _info():
	pass

func _extInit():
	._extInit()
	chaName = "摩西先知-传奇"
	lv = 4
	attCoe.atkRan = 3
	attCoe.maxHp = 6.5
	attCoe.atk = 6
	attCoe.mgiAtk = 7
	attCoe.def = 6
	attCoe.mgiDef = 6
	atkEff = "atk_dao"
	addCdSkill("c5_1_2", 3)
	addSkillTxt("每4次普通攻击:对周围1格敌方造成200%物理伤害，并附加[流血][中毒]各5层")
	addSkillTxt("每3秒：对1个敌方单位造成130%的魔法伤害，并附加[烧灼][中毒]各6层")
	addSkillTxt("当有单位死亡:本次战斗+30攻击力")
	addSkillTxt("非召唤单位死亡：50%概率召唤一个活尸")

var baseId = ""


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
				hurtChara(i, att.atk * 2.0, HurtType.PHY)
				i.addBuff(b_liuXue.new(5))
				i.addBuff(b_zhonDu.new(5))

func _onBattleStart():
	._onBattleStart()
	anum = 0
	attAdd.atk = 0
	pass
	
func _onCharaDel(cha):
	._onCharaDel(cha)
	if not cha.isSumm and isDeath == false and sys.rndPer(50):
		newChara("c6", cha.cell)
	attAdd.atk += 30
		
func _castCdSkill(id):
	._castCdSkill(id)
	if id == "c5_1_2" and aiCha != null:
		var d: Eff = newEff("sk_feiDang", sprcPos)
		d._initFlyCha(aiCha)
		yield(d, "onReach")
		hurtChara(aiCha, att.mgiAtk * 1.3, Chara.HurtType.MGI)
		aiCha.addBuff(b_zhonDu.new(6))
		aiCha.addBuff(b_shaoZhuo.new(6))
