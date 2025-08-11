extends Talent

func init():
	name = "恢复"

func _connect():
	sys.main.connect("onBattleEnd", self, "run")
	
func run():
	sys.main.chasPlusHp(0.1 + lv * 0.01, 0.05 + lv * 0.01)

func get_info():
	return tr("战斗结束场上和场下单位都额外恢复%d%%生命值") % [(0.1 + lv * 0.01) * 100]
