extends Chara

func _info():
	pass

func _extInit():
	._extInit()
	chaName = "魔王-传奇"
	lv = 4
	attCoe.atkRan = 1
	attCoe.maxHp = 7
	attCoe.atk = 6
	attCoe.mgiAtk = 6
	attCoe.def = 6
	attCoe.mgiDef = 6
	atkEff = "atk_dao"

	addSkillTxt("获得20%双吸血，免疫[中毒]，每有1%的物理吸血，提升1%的伤害。")
	addSkillTxt("每2秒,对最近单位造成100%的物理伤害，并额外发动1次普通攻击。")
	addSkillTxt("造成伤害时，治疗我方最低生命值的单位，治疗值等于50%的伤害值")
	addSkillTxt("每7秒：发射3枚飞弹，攻击随机的敌人，每发造成200%魔法伤害。")
	
	addCdSkill("a2_1", 5)

var baseId = ""


func _connect():
	._connect()
	
func _onAddBuff(buff: Buff):
	if buff is b_zhonDu:
		buff.isDel = true
	
func _upS():
	attAdd.atkR = att.suck * 1

func _castCdSkill(id):
	._castCdSkill(id)
	if id == "a2_1" and aiCha != null:
		normalAtkChara(aiCha)
		var d: Eff = newEff("sk_feiDang", sprcPos)
		d._initFlyCha(aiCha)
		yield(d, "onReach")
		hurtChara(aiCha, att.atk * 1, Chara.HurtType.PHY)
		
	elif id == "a2_2":
		for i in range(3):
			var chas: Array = getAllChas(1)
			if chas.size() > 0:
				var cha: Chara = chas[sys.rndRan(0, chas.size() - 1)]
				fx(cha)
			yield(reTimer(0.35), "timeout")

func _onAtkChara(atkInfo: AtkInfo):
	._onAtkChara(atkInfo)
	var cha = null
	var m = 10000
	var chas = getAllChas(2)
	for i in chas:
		if i.att.hp / i.att.maxHp < m:
			cha = i
			m = i.att.hp / i.att.maxHp
	if cha != null: cha.plusHp(atkInfo.hurtVal * 0.5)

func fx(cha):
	var d: Eff = newEff("sk_feiDang", sprcPos)
	d._initFlyCha(cha)
	yield(d, "onReach")
	if sys.isClass(cha, "Chara"):
		hurtChara(cha, att.mgiAtk * 2, Chara.HurtType.MGI)
