extends Item
	
func init():
	name = "熔岩吊坠"
	type = config.EQUITYPE_EQUI
	attInit()
	att.mgiAtk = 100
	
	info = tr("技能命中敌方单位时，赋予目标5层[烧灼]") + "\n" + tr("攻击命中有10层[烧灼]的单位时，召唤陨石对周围单位造成150%魔法伤害")

func _connect():
	masCha.connect("onAtkChara", self, "run")

func run(atkInfo: AtkInfo):
	if atkInfo.atkType == Chara.AtkType.SKILL:
		atkInfo.hitCha.addBuff(b_shaoZhuo.new(5))
		
	if atkInfo.atkType == Chara.AtkType.NORMAL:
		var bf = atkInfo.hitCha.hasBuff("b_shaoZhuo")
		if bf != null and bf.life >= 10:
			var eff: Eff = masCha.newEff("sk_yunShi")
			eff.position = atkInfo.hitCha.position
			bf.life -= 10
			var chas = masCha.getCellChas(atkInfo.hitCha.cell, 1)
			yield(sys.main.get_tree().create_timer(0.45), "timeout")
			for i in chas:
				masCha.hurtChara(i, masCha.att.mgiAtk * 1.5, Chara.HurtType.MGI, Chara.AtkType.EFF)
			
