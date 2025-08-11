extends Buff
class_name b_moYu
func _init(lv = 1):
	attInit()
	effId = "p_moYu"
	life = lv
	
func init():
	pass

func _connect():
	pass
	
func _upS():
	att.mgiDefL = (0.2 + life * 0.02) * pw
