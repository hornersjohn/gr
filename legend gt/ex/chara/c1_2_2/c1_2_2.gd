extends "res://ex/chara/c1_2/c1_2.gd"

func _info():
	pass

func _extInit():
	._extInit()
	chaName = "风行者"
	attCoe.atkRan += 2
	lv = 3
	evos = []
	addCdSkill("c1_2_2", 6)
	addSkillTxt("每7秒：射出穿透箭对直线上单位造成200%的物理伤害,并赋予5层[流血].")

func _connect():
	._connect()

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
