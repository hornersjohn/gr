extends Ach

func _connect():
	sys.main.connect("onBossEnd", self, "onBossEnd")
	sys.main.connect("onEvo", self, "onEvo")
	sys.main.connect("onTongGuan", self, "onTongGuan")
	sys.main.player.connect("onPlusGold", self, "onPlusGold")

func onTongGuan(lv):
	if sys.godotSteam != null: sys.godotSteam.ach("tongGuan%d" % lv)

func onEvo(cha):
	if sys.godotSteam != null: sys.godotSteam.ach("evo%d" % cha.lv)
	
func onBossEnd(lv):
	if sys.godotSteam != null: sys.godotSteam.ach("lv%d" % lv)

var goldBl = false
func onPlusGold(val):
	if goldBl == false and player.gold >= 1000:
		goldBl = true
		sys.godotSteam.ach("gold1")
