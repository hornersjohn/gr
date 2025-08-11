extends "res://ui/msgBase/msgBase.gd"

func _ready():
	if sys.test:
		$VBoxContainer / tuPu2.show()
	else:
		$VBoxContainer / tuPu2.hide()

func _on_Button_pressed():
	if sys.main.guanKaBtn.step == 0 and sys.main.isEnd == false:
		sys.newBaseMsg("提示", "请在非战斗时存档。")
	else:
		sys.main.exit()
		queue_free()
	
func _on_tuPu_pressed():
	sys.newMsg("modGuanLi").init()

func _on_tuPu2_pressed():
	sys.newMsg("modUpdate").init()
	pass

func _on_tuPu3_pressed():
	if sys.isMin:
		sys.newMsgL("modSubMsg/minModSubMsg").init()
	else:
		sys.newMsg("modSubMsg").init()
	pass

func _on_tuPu4_pressed():
	sys.newMsg("sheZhi").init()
	pass

func _on_tuoxian_pressed():
	if sys.main.isEnd == false:
		sys.newMsg("jieSuan").init(false)
		sys.main.exit()
		queue_free()
	else:
		sys.newBaseMsg("提示", "已经结算了。")
