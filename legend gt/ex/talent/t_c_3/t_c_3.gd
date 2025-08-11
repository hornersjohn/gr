extends Talent

func init():
	name = "修女训练"

func _connect():
	sys.main.connect("onBattleStart", self, "run")
	
func run():
	for i in sys.main.btChas:
		if (i.id.find("c3") != - 1 or i.id == "cex___3") and i.team == 1:
			i.addBuff(Bf.new(lv))

func get_info():
	return tr("修女系列生物 提升伤害 和 减少承受伤害 各 %d%%") % [(0.15 + lv * 0.02) * 100]

class Bf:
	extends Buff

	func _init(lv):
		self.lv = lv
		attInit()
		att.atkR = 0.15 + lv * 0.02
		att.defR = 0.15 + lv * 0.02
