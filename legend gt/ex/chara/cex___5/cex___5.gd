extends Chara

func _info():
	pass

func _extInit():
	._extInit()
	chaName = "剑神-传奇"
	lv = 4
	attCoe.atkRan = 3
	attCoe.maxHp = 6
	attCoe.atk = 6
	attCoe.mgiAtk = 3
	attCoe.def = 6
	attCoe.mgiDef = 6
	atkEff = "atk_dao"
	addCdSkill("5_1_1", 10)
	addSkillTxt("每10秒：使友军获得[抵御][魔御][狂怒]15层")
	addCdSkill("5_1_2", 10)
	addSkillTxt("每10秒：霸王斩对直线单位造成200%物理伤害，普通攻击减少20%冷却")
	attAdd.dod += 0.6
	addSkillTxt("30%的概率闪避普通攻击,获得等同于闪避的暴击率")
	attAdd.cri = 0.15
	addSkillTxt("+15%暴击，暴击时额外造成100%的物理伤害")

var baseId = ""


func _connect():
	._connect()
	attAdd.cri = att.dod
	upAtt()

func _castCdSkill(id):
	._castCdSkill(id)
	if id == "5_1_1":
		var chas = getAllChas(2)
		for i in chas:
			i.addBuff(b_diYu.new(15))
			i.addBuff(b_moYu.new(15))
			i.addBuff(b_kuangNu.new(15))
	
	if id == "5_1_2" and aiCha != null:
		var eff: Eff = newEff("sk_feiZhan", sprcPos)
		eff._initFlyPos(position + (aiCha.position - position).normalized() * 300, 300)
		eff.connect("onInCell", self, "effInCell")

func effInCell(cell):
	var cha = matCha(cell)
	if cha != null and cha.team != team:
		hurtChara(cha, att.atk * 2)
		

func _onAtkChara(atkInfo):
	._onAtkChara(atkInfo)
	if atkInfo.atkType == AtkType.NORMAL:
		var sk = getSkill("5_1_2")
		sk.nowTime += sk.cd * 0.2
	if atkInfo.isCri:
		hurtChara(atkInfo.hitCha, att.atk * 1)

func _upS():
	attAdd.cri = att.dod
