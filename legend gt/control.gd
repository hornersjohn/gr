extends Control




var tw = null

func _ready():
	Engine.time_scale = 1.0
	tw = Tween.new()
	add_child(tw)


	audio.playBgm("tile")
	$RichTextLabel.text += "----------\n"
	for i in chaData.infos:
		$RichTextLabel.text += i.id + "\n"
	$RichTextLabel.text += "----------\n"
	
	var file = File.new()
	if file.open("user://data1/main.save", File.READ) == OK:
		$Panel2 / Panel / jiXuBtn.show()
	else: $Panel2 / Panel / jiXuBtn.hide()
	
	for i in topUi.get_children():
		i.queue_free()
		
	if sys.isMin:
		$Panel2 / Panel / Button6.hide()
	if sys.quDao == "steam":
		$cardMakerheader.hide()
	
func _init():
	pass

func _on_Button_pressed():
	sys.newMsg("jinJieMsg").init()




func _on_Button2_pressed():
	var msg = sys.newMsg("selTuPuMsg")
	msg.popup()
	
func _on_Button3_pressed():
	get_tree().quit()

func _on_Button4_pressed():
	pass

func _on_Button6_pressed():
	if sys.godotSteam != null: sys.newMsg("paiHang").popup()

func _on_Button5_pressed():
	sys.newMsg("sheZhi").init()
	pass

func _on_Button7_pressed():
	if sys.isMin:
		sys.newMsgL("modSubMsg/minModSubMsg").init()
	else:
		sys.newMsg("modOpt").popup()

func _on_jiXuBtn_pressed():
	var main = preload("res://main.tscn").instance()
	queue_free()
	sys.get_parent().add_child(main)
	main.loadInfo()

func _on_cardMakerBtn_onPressed():
	OS.shell_open("https://store.steampowered.com/app/1595280/CardMaker/")
