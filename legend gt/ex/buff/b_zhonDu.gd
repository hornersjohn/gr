extends Buff
class_name b_zhonDu
func _init(lv = 1):
	attInit()
	effId = "p_zhonDu"
	life = lv
	isNegetive = true
	
func init():
	pass

func _connect():
	pass
	
func _upS():
	
	att.reHp = - (0.1 + life * 0.01) * pw
	att.defL = - (0.1 + life * 0.01) * pw
	att.mgiDefL = - (0.1 + life * 0.01) * pw
