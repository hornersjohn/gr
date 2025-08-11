extends Item
	
func init():
	name = "拉锯拳刃"
	type = config.EQUITYPE_EQUI
	attInit()
	att.spd = 0.4
	att.cri = 0.3
	
	info = tr("每5秒：获得5层狂怒") + "\n" + tr("当你获得[狂怒]时也获得相应层数的[急速]")

func _connect():
	masCha.connect("onAddBuff", self, "run")
	sn = 0

var sn = 0
func _upS():
	sn += 1
	if sn >= 5:
		sn = 0
		masCha.addBuff(b_kuangNu.new(5))

func run(buff):
	if buff is b_kuangNu:
		masCha.addBuff(b_jiSu.new(5))
