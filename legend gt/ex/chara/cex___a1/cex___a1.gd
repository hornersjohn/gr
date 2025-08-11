extends Chara

func _info():
	pass

func _extInit():
	._extInit()
	chaName = "悍将-传奇"
	lv = 4
	attCoe.atkRan = 1
	attCoe.maxHp = 7
	attCoe.atk = 6
	attCoe.mgiAtk = 6
	attCoe.def = 6
	attCoe.mgiDef = 6
	attAdd.cri = 0.2
	atkEff = "atk_dao"

	addSkillTxt("获得额外20%暴击率，并使cd技能也能够暴击")
	addCdSkill("10_1", 5)
	addSkillTxt("每5秒：对周围1格单位照成100%物理伤害")
	addSkillTxt("普通攻击暴击时，释放第二个技能。")
	addSkillTxt("暴击时，回复该次伤害的生命值。")
	addCdSkill("10_2_2", 7)
	addSkillTxt("每7秒：发射3枚火球，攻击最近的敌人，造成200%魔法伤害,并附加7层烧灼")

var baseId = ""


func _connect():
	._connect()
	
func _onAtkInfo(atkInfo: AtkInfo):
	._onAtkInfo(atkInfo)
	if atkInfo.atkCha == self and atkInfo.atkType == AtkType.SKILL:
		atkInfo.canCri = true
		
func _onAtkChara(atkInfo: AtkInfo):
	._onAtkChara(atkInfo)
	if atkInfo.isCri:
		plusHp(atkInfo.hurtVal)

	if atkInfo.atkType == AtkType.NORMAL and atkInfo.isCri:
		_castCdSkill("10_1")
		emit_signal("onCastCdSkill", "10_1")
		sys.main.emit_signal("onCharaCastCdSkill", self, "10_1")
		_onCharaCastCdSkill(self, "10_1")
		newEff("xuLi2").setNorPos(sprcPos)
		
func _castCdSkill(id):
	._castCdSkill(id)
	if id == "10_2_2":
		var chas = getAllChas()
		chas.sort_custom(self, "sort")
		for i in range(3):
			if i >= chas.size(): break
			var cha: Chara = chas[i]
			fx(cha)
	if id == "10_1":
		var chas = getCellChas(cell, 1)
		for i in chas:
			hurtChara(i, att.atk * 1, HurtType.PHY)

func sort(a, b):
	if cellRan(a.cell, cell) < cellRan(b.cell, cell):
		return true
	return false

func fx(cha):
	var d: Eff = newEff("sk_4_1_2", sprcPos)
	d._initFlyCha(cha)
	yield(d, "onReach")
	if sys.isClass(cha, "Chara"):
		hurtChara(cha, att.mgiAtk * 2, Chara.HurtType.MGI)
		cha.addBuff(b_shaoZhuo.new(7))
