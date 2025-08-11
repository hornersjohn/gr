extends Item
	
func init():
	name = "骷髅之戒"
	type = config.EQUITYPE_EQUI
	attInit()
	att.atk = 75
	att.cri = 0.2
	info = "穿戴者杀死生物召唤1个骷髅士兵"

func _connect():
	masCha.connect("onKillChara", self, "run")

func run(atkInfo):
	if atkInfo.hitCha.isSumm == false:
		masCha.newChara("c6_1", atkInfo.hitCha.cell)
