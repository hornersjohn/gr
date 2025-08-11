extends MsgBaseX








func _ready():
	pass
	




func _on_Button_pressed():
	var kuaiBao = null
	if sys.has_node("kuaiBao"):
		sys.get_node("kuaiBao").jiHuo($Panel / LineEdit.text)
		sys.get_node("kuaiBao").jihuoBtn = true
		
func _on_Button2_pressed():
	get_tree().quit()
	pass

var btime = 0

func _on_LineEdit_gui_input(event):
	if event is InputEventMouseButton:
		if event.button_index == 1:
			btime = 0.5
		else:
			btime = 0

func _process(delta):
	if btime > 0:
		btime -= delta
		if btime <= 0:
			$Panel / LineEdit.get_menu().show()
			$Panel / LineEdit.get_menu().rect_position = get_global_mouse_position()

func _on_Panel_gui_input(event):
	if event is InputEventMouseButton:
		if event.button_index == 1:
			$Panel / LineEdit.get_menu().hide()

func _on_Button3_pressed():
	OS.shell_open("https://m.3839.com/article/926916.html")
