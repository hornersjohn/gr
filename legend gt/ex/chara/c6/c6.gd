extends Chara

func _info():
	pass

func _extInit():
	._extInit()
	chaName = "活尸"
	attCoe.atkRan = 1
	attCoe.maxHp = 3
	attCoe.atk = 3
	attCoe.mgiAtk = 2
	attCoe.def = 3
	attCoe.mgiDef = 3
	lv = 1
	atkEff = "atk_dao"
	addSkillTxt("死亡尸爆:1格内敌方附加[烧灼][中毒]各7层")

func _connect():
	._connect()

func _onDeath(atkInfo):
	var eff: Eff = newEff("sk_shiBao")
	eff.position = position
	var chas = getCellChas(cell, 1)
	yield(reTimer(0.05), "timeout")
	for i in chas:
		i.addBuff(b_zhonDu.new(7))
		i.addBuff(b_shaoZhuo.new(7))




