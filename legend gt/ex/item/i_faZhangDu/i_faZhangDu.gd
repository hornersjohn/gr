extends Item
	
func init():
	name = "剧毒之杖"
	type = config.EQUITYPE_EQUI
	attInit()
	att.mgiAtk = 100
	
	info = tr("技能命中敌方单位时，赋予目标5层[中毒]") + "\n" + tr("攻击命中有10层[中毒]的单位时，毒爆周围单位造成150%魔法伤害")

func _connect():
	masCha.connect("onAtkChara", self, "run")

func run(atkInfo: AtkInfo):
	if atkInfo.atkType == Chara.AtkType.SKILL:
		atkInfo.hitCha.addBuff(b_zhonDu.new(5))
		
	if atkInfo.atkType == Chara.AtkType.NORMAL:
		var bf = atkInfo.hitCha.hasBuff("b_zhonDu")
		if bf != null and bf.life >= 10:
			bf.life -= 10
			var eff: Eff = masCha.newEff("sk_shiBao")
			eff.position = atkInfo.hitCha.position
			var chas = masCha.getCellChas(atkInfo.hitCha.cell, 1)
			for i in chas:
				masCha.hurtChara(i, masCha.att.mgiAtk * 1.5, Chara.HurtType.MGI, Chara.AtkType.EFF)
			
