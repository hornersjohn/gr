extends Buff
class_name b_kuangNu
func _init(lv = 1):
	attInit()
	effId = "p_kuangNu"
	life = lv
	
func init():
	pass

func _connect():
	pass
	
func _upS():
	att.atkL = (0.2 + life * 0.02) * pw
