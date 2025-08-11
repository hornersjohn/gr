extends Buff
class_name b_shaoZhuo
func _init(lv = 1):
	attInit()
	effId = "p_shaoZhuo"
	life = lv
	isNegetive = true
	
func init():
	pass

func _connect():
	pass
	
func _upS():
	masCha.hurtChara(masCha, masCha.att.maxHp * (0.01 + life * 0.001) * pw, Chara.HurtType.REAL, Chara.AtkType.EFF)
