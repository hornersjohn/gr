extends Buff
class_name b_jieShuang
func _init(lv = 1):
	attInit()
	effId = "p_jieShuang"
	life = lv
	isNegetive = true
	
func init():
	pass

func _connect():
	pass
	
func _upS():
	att.spd = - (0.2 + life * 0.02) * pw
	att.cd = - (0.2 + life * 0.02) * pw
