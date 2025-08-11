extends Buff
class_name b_jiSu
func _init(lv = 1):
	attInit()
	effId = "p_jiSu"
	life = lv
	
func init():
	pass

func _connect():
	pass
	
func _upS():
	att.spd = (0.2 + life * 0.02) * pw
