extends Item
	
func init():
	name = "王者戒"
	type = config.EQUITYPE_EQUI
	attInit()
	att.atk = 50
	att.mgiAtk = 70
	info = "你召唤的生物,获得20层急速，狂怒"
	
func _connect():
	masCha.connect("onNewChara", self, "run")

func run(cha):
	cha.addBuff(b_jiSu.new(20))
	cha.addBuff(b_kuangNu.new(20))
