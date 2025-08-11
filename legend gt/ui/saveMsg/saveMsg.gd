extends MsgBaseX





signal onP(inx)


func _ready():
	popup()







func _on_Button2_pressed():
	queue_free()
	emit_signal("onP", 0)

func _on_Button_pressed():
	queue_free()
	emit_signal("onP", 1)
	sys.main.exit()
	pass


func _on_Button3_pressed():
	queue_free()
	if sys.main.isEnd == false:
		sys.main.isEnd = true
		sys.main.exit()
		sys.newMsg("jieSuan").init(false)
	else:
		sys.newBaseMsg("提示", "已经结算了。")
	pass
