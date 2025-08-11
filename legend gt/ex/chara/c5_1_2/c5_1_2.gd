extends "res://ex/chara/c5_1/c5_1.gd"

func _info():
	pass

func _extInit():
	._extInit()
	chaName = "英雄"
	lv = 3
	addCdSkill("5_1_2", 10)
	addSkillTxt("每10秒：霸王斩对直线单位造成200%物理伤害，普通攻击减少20%冷却")

func _connect():
	._connect()
				
func _castCdSkill(id):
	._castCdSkill(id)
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
