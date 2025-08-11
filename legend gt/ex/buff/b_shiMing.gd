extends Buff
class_name b_shiMing
func _init(lv = 1):
	effId = "p_shiMing"
	life = lv
	isNegetive = true
	
func init():
	pass

func _connect():
	masCha.connect("onAtkChara", self, "_onAtkChara")

func _onAtkChara(atkInfo: AtkInfo):
	if atkInfo.atkType == Obj.AtkType.NORMAL and sys.rndPer((30 + life * 3) * pw):
		atkInfo.isMiss = true
		atkInfo.atkType = Chara.AtkType.MISS
