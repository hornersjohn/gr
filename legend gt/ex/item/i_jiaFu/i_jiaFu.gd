extends Item
	
func init():
	name = "复活甲"
	type = config.EQUITYPE_EQUI
	attInit()
	att.maxHp = 300
	att.def = 60
	att.mgiDef = 60
	info = "濒临死亡复活1次，恢复50%生命值"

func _connect():
	masCha.connect("onDeath", self, "run1")
	sys.main.connect("onBattleStart", self, "run2")
	
var n = 0
func run1(id):
	if n < 1 and masCha.isDeath:
		n += 1
		masCha.isDeath = false
		masCha.plusHp(masCha.att.maxHp * 0.5)

func run2():
	n = 0
