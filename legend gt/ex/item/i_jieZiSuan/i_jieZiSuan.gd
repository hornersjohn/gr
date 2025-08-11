extends Item
	
func init():
	name = "冰霜戒指"
	type = config.EQUITYPE_EQUI
	attInit()
	att.mgiAtk = 80
	att.atk = 70
	
	info = tr("技能命中敌方单位时，赋予目标5层[结霜]") + "\n" + tr("当敌方10层以上[结霜]的单位死亡，获得2金币,每场战斗限6金币")

func _connect():
	masCha.connect("onAtkChara", self, "run")
	masCha.connect("onCharaDel", self, "run2")
	sys.main.connect("onBattleStart", self, "run3")

func run(atkInfo: AtkInfo):
	if atkInfo.atkType == Chara.AtkType.SKILL:
		atkInfo.hitCha.addBuff(b_jieShuang.new(5))

func run2(cha):
	var bf = cha.hasBuff("b_jieShuang")
	if bf != null and bf.life >= 10 and n < 6 and masCha.team == 1:
		sys.main.player.plusGold(2)
		n += 2

var n = 0

func run3():
	n = 0
