extends Item
	
func init():
	name = "混沌魔剑"
	type = config.EQUITYPE_EQUI
	attInit()
	att.atk = 80
	att.mgiAtk = 80
	info = "造成伤害附加随机负面buff10层。"

func _connect():
	masCha.connect("onAtkChara", self, "run")

func run(atkInfo: AtkInfo):
	if atkInfo.atkType == Chara.AtkType.SKILL or atkInfo.atkType == Chara.AtkType.NORMAL:
		var bf = null
		var n = sys.rndRan(0, 3)
		if n == 0:
			bf = b_shaoZhuo.new(10)
		elif n == 1:
			bf = b_liuXue.new(10)
		elif n == 2:
			bf = b_jieShuang.new(10)
		else:
			bf = b_zhonDu.new(10)
		atkInfo.hitCha.addBuff(bf)
