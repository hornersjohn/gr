extends Item
	
func init():
	name = "好书"
	type = config.EQUITYPE_EQUI
	attInit()
	att.atk = 80
	att.mgiAtk = 100
	info = "施放cd技能会获得[急速]15秒"

func _connect():
	masCha.connect("onCastCdSkill", self, "run1")

func run1(id):
	masCha.addBuff(b_jiSu.new(15))
