extends "res://ex/chara/ca2/ca2.gd"


func _info():
	pass

func _extInit():
	._extInit()
	chaName = "魔女"
	attCoe.atkRan = 3
	lv = 2
	addCdSkill("a2_2", 7)
	addSkillTxt("每7秒：发射3枚飞弹，攻击随机的敌人，每发造成200%魔法伤害。")

func _connect():
	._connect()

func _castCdSkill(id):
	._castCdSkill(id)
	if id == "a2_2":
		for i in range(3):
			var chas: Array = getAllChas(1)
			if chas.size() > 0:
				var cha: Chara = chas[sys.rndRan(0, chas.size() - 1)]
				fx(cha)
			yield(reTimer(0.35), "timeout")

func fx(cha):
	var d: Eff = newEff("sk_feiDang", sprcPos)
	d._initFlyCha(cha)
	yield(d, "onReach")
	if sys.isClass(cha, "Chara"):
		hurtChara(cha, att.mgiAtk * 2, Chara.HurtType.MGI)
