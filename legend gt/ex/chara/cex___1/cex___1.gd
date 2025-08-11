extends Chara

func _info():
	pass

func _extInit():
	._extInit()
	chaName = "女武神-传奇"
	lv = 4
	attCoe.atkRan = 1
	attCoe.maxHp = 6
	attCoe.atk = 7
	attCoe.mgiAtk = 3
	attCoe.def = 6
	attCoe.mgiDef = 6
	attAdd.dod = 0.3
	attAdd.cri += 0.5
	atkEff = "atk_dao"
	addCdSkill("c1_2_2", 6)
	addSkillTxt("受到普通攻击时，30%概率格挡并反击对方(视为普通攻击)。")
	addSkillTxt("每损失1%的生命值，获得1%的攻速和攻击力！")
	addSkillTxt("增加50%暴击。")
	addSkillTxt("每7秒：射出穿透箭对直线上单位造成200%的物理伤害,并赋予5层[流血].")

var baseId = ""


func _connect():
	._connect()

func _onHurt(atkInfo: AtkInfo):
	._onHurt(atkInfo)
	if atkInfo.isMiss:
		normalAtkChara(atkInfo.atkCha)
	attAdd.spd = 0.3 + (1.0 - att.hp / att.maxHp)
	attAdd.atkL = 1.0 - (att.hp / att.maxHp)

func _castCdSkill(id):
	._castCdSkill(id)
	if id == "c1_2_2" and aiCha != null:
		var eff: Eff = newEff("sk_chuanTouJian", sprcPos)
		eff._initFlyPos(position + (aiCha.position - position).normalized() * 1000, 250)
		eff.connect("onInCell", self, "effInCell")

func effInCell(cell):
	var cha = matCha(cell)
	if cha != null and cha.team != team:
		hurtChara(cha, att.atk * 2)
		cha.addBuff(b_liuXue.new(5))
