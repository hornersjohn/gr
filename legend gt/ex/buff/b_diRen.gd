extends Buff
class_name b_diRen
func _init(lv = 1):
	attInit()
	effId = "p_diYu"
	life = lv
	
func init():
	pass

func _connect():
	pass
	
func _upS():
	att.defL = (0.2 + life * 0.02) * pw
