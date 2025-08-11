extends Item
	
func init():
	name = "狂怒匕首"
	type = config.EQUITYPE_EQUI
	attInit()
	att.atk = 70
	att.cri = 0.3
	info = "暴击时获得5层狂怒"

func _connect():
	masCha.connect("onAtkChara", self, "run")

func run(atkInfo: AtkInfo):
	if atkInfo.isCri: masCha.addBuff(b_kuangNu.new(5))
