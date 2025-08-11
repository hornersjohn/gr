extends Item
	
func init():
	name = "项链"
	type = config.EQUITYPE_EQUI
	attInit()
	att.atk = 70
	att.mgiAtk = 80
	info = "穿戴者杀死非召唤单位获得2金币,每场战斗限6金币"

func _connect():
	masCha.connect("onKillChara", self, "run1")
	sys.main.connect("onBattleStart", self, "run3")

func run1(atkInfo: AtkInfo):
	if atkInfo.hitCha.isSumm == false and masCha.team == 1 and n < 6:
		sys.main.player.plusGold(2)
		n += 2

var n = 0

func run3():
	n = 0
