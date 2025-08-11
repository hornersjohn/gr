extends Talent

func init():
	name = "冷却掌握"

func _connect():
	sys.main.connect("onBattleStart", self, "run")
	
func run():
	for i in sys.main.btChas:
		if i.team == 1:
			i.addBuff(Bf.new(lv))

func get_info():
	return tr("战斗时 你的所有生物 技能冷却速度提升 %d%%") % [(0.1 + lv * 0.01) * 100]

class Bf:
	extends Buff

	func _init(lv):
		self.lv = lv
		attInit()
		att.cd = 0.1 + lv * 0.01
