extends "res://ex/chara/c8_1/c8_1.gd"

func _info():
	pass

func _extInit():
	._extInit()
	chaName = "冰龙"
	lv = 3
	
	
	addCdSkill("c8_1_2", 7)
	addSkillTxt("每7秒：对敌方攻击和法强最高的单位造成200%的魔法伤害，并附加10层结霜")

func _connect():
	._connect()

func _onBattleStart():
	._onBattleStart()
	var sk = getSkill("c8_1_2")
	

func _castCdSkill(id):
	._castCdSkill(id)
	if id == "c8_1_2":
		var chas = getAllChas()
		if chas.size() == 0: return
		var ac = chas[0]
		var bc = chas[0]
		for i in chas:
			if ac.att.atk < i.att.atk: ac = i
			if ac.att.mgiAtk < i.att.mgiAtk: bc = i
		fx(ac)
		if ac != bc: fx(bc)
		
func fx(cha):
	var d: Eff = newEff("sk_feiDang", sprcPos)
	d._initFlyCha(cha)
	yield(d, "onReach")
	if sys.isClass(cha, "Chara"):
		hurtChara(cha, att.mgiAtk * 1.7, Chara.HurtType.MGI)
		cha.addBuff(b_jieShuang.new(10))
		pass
