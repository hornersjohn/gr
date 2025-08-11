extends Talent

func init():
	name = "急速强化"

func _connect():
	sys.main.connect("onCharaAddBuff", self, "run")

func get_info():
	return tr("你的[急速]效果增强%d%%") % [30 + lv * 10]

func run(buff: Buff):
	if buff.id == "b_jiSu" and buff.masCha.team == 1:
		buff.pw = 1.3 + lv * 0.1
