extends Talent

func init():
	name = "流血强化"

func _connect():
	sys.main.connect("onCharaAddBuff", self, "run")

func get_info():
	return tr("你对敌人的[流血]效果增强%d%%") % [30 + lv * 10]

func run(buff: Buff):
	if buff.id == "b_liuXue" and buff.masCha.team == 2:
		buff.pw = 1.3 + lv * 0.1
