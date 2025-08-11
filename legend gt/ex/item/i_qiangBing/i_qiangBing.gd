extends Item
	
func init():
	name = "霜之枪"
	type = config.EQUITYPE_EQUI
	attInit()
	att.atk = 80
	att.dod = 0.3
	info = "闪避时使目标附加4层[结霜]"

func _connect():
	masCha.connect("onHurt", self, "run")

func run(atkInfo: AtkInfo):
	if atkInfo.atkType == Chara.AtkType.NORMAL and atkInfo.isMiss:
			atkInfo.atkCha.addBuff(b_jieShuang.new(4))
