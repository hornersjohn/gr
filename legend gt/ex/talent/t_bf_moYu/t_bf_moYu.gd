extends Talent

func init():
	name = "魔御强化"

func _connect():
	sys.main.connect("onCharaAddBuff", self, "run")

func get_info():
	return tr("你的[魔御]效果增强%d%%") % [30 + lv * 10]

func run(buff: Buff):
	if buff.id == "b_moYu" and buff.masCha.team == 1:
		buff.pw = 1.3 + lv * 0.1
