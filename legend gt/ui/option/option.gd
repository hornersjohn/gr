extends "res://ui/msgBase/msgBase.gd"

func _ready():
	$VBoxContainer.alignment = BoxContainer.ALIGN_CENTER


func _on_Button_pressed():
	if sys.main.guanKaBtn.step == 0 and sys.main.isEnd == false:
		sys.newBaseMsg("提示", "请在非战斗时存档。")
	else:
		if sys.main.isEnd == false:
			queue_free()
			var msg = sys.newMsg("saveMsg")
			
		else:
			sys.main.exit()
	
func _on_tuPu_pressed():
	sys.newMsg("tuPu").init()

func _on_tuPu2_pressed():
	sys.newMsg("tuPuItemMsg").init()
	pass

func _on_tuPu3_pressed():
	sys.newMsg("tuPuBuff").init()
	pass

func _on_tuPu4_pressed():
	sys.newMsg("sheZhi").init()
	pass

func _on_tuoxian_pressed():
	if sys.main.isEnd == false:
		sys.main.isEnd = true
		sys.main.exit()
		queue_free()
		sys.newMsg("jieSuan").init(false)
	else:
		sys.newBaseMsg("提示", "已经结算了。")
