extends "res://ui/msgBaseX/msgBaseX.gd"








func _ready():
	pass


func init():
	popup()





func _on_Button_pressed():
	updata()

func _on_Button_mod_pressed():
	$FileDialog.popup()

func _on_png_pressed():
	$FileDialog2.popup()
	pass

func _on_FileDialog_dir_selected(dir):
	$Panel / dir / Label.text = dir
	var file_name = $Panel / dir / Label.text + "/itemId.dic"
	var file = File.new()
	if file.open(file_name, File.READ) == OK:
		var dic = parse_json(file.get_line())
		if dic == null: print_debug("读取存档错误")
		if dic.has("id"): $Panel / id.text = str(dic["id"])
		if dic.has("tile"): $Panel / tile / LineEdit.text = dic["tile"]
		if dic.has("info"): $Panel / info / LineEdit.text = dic["info"]
		if dic.has("dir"): $Panel / dir / Label.text = dic["dir"]
		if dic.has("png"): $Panel / file / Label.text = dic["png"]
		file.close()

func _on_FileDialog2_file_selected(path):
	$Panel / file / Label.text = path

func updata():
	if $Panel / tile / LineEdit.text == "":
		sys.newBaseMsg("提示", "标题还未填写。")
		return
	elif $Panel / info / LineEdit.text == "":
		sys.newBaseMsg("提示", "描述还未填写。")
		return
	elif $Panel / dir / Label.text == "":
		sys.newBaseMsg("提示", "未选择目录。")
		return
	elif $Panel / file / Label.text == "":
		sys.newBaseMsg("提示", "未选择封面图。")
		return
	
	$Button2.text = "上传中-请等待"
	$Button2.disabled = true
	$Button.disabled = true
	var file_name = $Panel / dir / Label.text + "/itemId.dic"
	var file = File.new()
	var itemId = null
	if file.open(file_name, File.READ) == OK:
		var dic = parse_json(file.get_line())
		file.close()
		if dic == null: print_debug("读取存档错误")
		if dic.has("id"): itemId = dic["id"]
	sys.godotSteam.item_Up(itemId, $Panel / tile / LineEdit.text, $Panel / info / LineEdit.text, $Panel / dir / Label.text, $Panel / file / Label.text)
	yield(sys.godotSteam, "on_item_updated")
	$Button2.text = "返回"
	$Button2.disabled = false
	$Button.disabled = false

func _on_Button2_pressed():
	queue_free()
	pass

func _on_wenhao_pressed():
	sys.newBaseMsg("提示", "请把你制作的若干mod，放到同一个文件夹里，然后选择这个文件夹。之后请保留这个文件夹，下次读取并上传它，会更新相应的创意工坊的物品。")
