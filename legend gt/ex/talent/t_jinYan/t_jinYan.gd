extends Talent

func init():
	name = "经验"

func _connect():
	sys.main.connect("onBattleEnd", self, "run")
	
func run():
	player.plusEmp(4 + lv * 3)

func get_info():
	return tr("战斗结束额外获得%d经验") % [4 + lv * 3]
