extends "res://ex/chara/c8_1/c8_1.gd"

func _info():
	pass

func _extInit():
	._extInit()
	chaName = "炎龙"
	lv = 3
	
	addSkillTxt("普攻额外攻击2名最近的敌人，造成50%魔法伤害（视为普通攻击），附加1层[烧灼]")

func _connect():
	._connect()

var p = 0.5
					
func _onNormalAtk(cha):
	._onNormalAtk(cha)
	if atkInfo.atkType == AtkType.NORMAL:
		hurtChara(cha, att.mgiAtk * p, Chara.HurtType.MGI, Chara.AtkType.EFF)
		cha.addBuff(b_shaoZhuo.new(1))
		var chas = getCellChas(cell, att.atkRan)
		
		chas.sort_custom(self, "sort")
		var n = 0
		for i in chas:
			if i != cha:
				n += 1
				fx(i)
				if n == 2:
					break
					
func sort(a, b):
	if cellRan(a.cell, cell) < cellRan(b.cell, cell):
		return true
	return false
	
func fx(cha):
	var d: Eff = newEff("atk_dang", sprcPos)
	d._initFlyCha(cha)
	yield(d, "onReach")
	if sys.isClass(cha, "Chara"):
		hurtChara(cha, att.mgiAtk * p, Chara.HurtType.MGI, Chara.AtkType.NORMAL)
		cha.addBuff(b_shaoZhuo.new(1))
