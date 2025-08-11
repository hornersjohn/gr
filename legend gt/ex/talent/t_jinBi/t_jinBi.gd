extends Talent

func init():
	name = "运筹"

func _connect():
	sys.main.connect("onBattleEnd", self, "run")
	
func run():
	player.plusGold(2 + lv * 1)

func get_info():
	return tr("战斗结束额外获得%d金币") % [2 + lv]
