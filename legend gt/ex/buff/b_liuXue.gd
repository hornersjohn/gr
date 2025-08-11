extends Buff
class_name b_liuXue
func _init(lv = 1):
	attInit()
	effId = "p_liuXue"
	life = lv
	isNegetive = true
	
func init():
	pass

func _connect():
	masCha.connect("onHurt", self, "onHurt")
	

func onHurt(atkInfo: AtkInfo):
	if atkInfo.atkType != Chara.AtkType.EFF:
		atkInfo.atkCha.hurtChara(masCha, atkInfo.atkVal * (0.3 + life * 0.03) * pw, Chara.HurtType.PHY, Chara.AtkType.EFF)
