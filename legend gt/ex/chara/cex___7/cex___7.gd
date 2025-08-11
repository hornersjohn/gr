extends Chara

func _info():
	pass

func _extInit():
	._extInit()
	chaName = "荒诞之树-传奇"
	lv = 4
	attCoe.atkRan = 3
	attCoe.maxHp = 7
	attCoe.atk = 6
	attCoe.mgiAtk = 6
	attCoe.def = 6
	attCoe.mgiDef = 6
	atkEff = "atk_dao"
	addCdSkill("c7_2", 10)
	addSkillTxt("每10秒：恢复15%的生命值，我方单位释放技能时，减少4%冷却")
	addCdSkill("c7_1_2", 13)
	addSkillTxt("每13秒，召唤一颗人参果")
	addSkillTxt("任意角色召唤1个单位时，永久+5生命值")
	addCdSkill("c7_2_2", 10)
	addSkillTxt("每10秒：缠绕所有拥有负面buff的敌人，翻倍该负面buff的层数")

var baseId = ""


func _connect():
	._connect()
















		
func _castCdSkill(id):
	._castCdSkill(id)
	if id == "c7_1_2":
		newChara("c7_1", self.cell)
	if id == "c7_2":
		plusHp(att.maxHp * 0.15, true)
	
	if id == "c7_2_2":
		var chas = getAllChas(1)
		var sf
		for cha in chas:
			for bf in cha.buffs:
				if bf.isNegetive:
					sf = bf
					bf.life *= 2
			if sf != null:
				var eff = newEff("huohua")
				eff.position = cha.position
	
func _onCharaNewChara(cha):
	._onCharaNewChara(cha)
	attInfo.maxHp += 5
	upAtt()


func _onCharaCastCdSkill(cha, id):
	._onCharaCastCdSkill(cha, id)
	if cha.team == self.team:
		var sk = getSkill("c7_2")
		sk.nowTime += sk.cd * 0.04
