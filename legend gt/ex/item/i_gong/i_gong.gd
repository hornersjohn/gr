extends Item
	
func init():
	name = "风之弓"
	type = config.EQUITYPE_EQUI
	attInit()
	att.atkRan = 2
	att.atk = 60
	att.spd = 0.3
	info = "每次普通攻击获得2层[急速]"

func _connect():
	masCha.connect("onAtkChara", self, "run")

func run(atkInfo: AtkInfo):
	if atkInfo.atkType == Chara.AtkType.NORMAL: masCha.addBuff(b_jiSu.new(2))
