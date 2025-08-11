extends "res://ui/msgBase/msgBase.gd"





onready var box = $ItemList / VBoxContainer


func _ready():
	pass

func init():
	popup()
	for i in Steam.getSubscribedItems():
		var dc = Steam.getItemInstallInfo(i)
		var id = str(i)
		var file_name = dc["folder"] + "/itemId.dic"
		var file = File.new()
		if file.open(file_name, File.READ) == OK:
			var dic = parse_json(file.get_line())
			file.close()
			var item = preload("modItem.tscn").instance()
			box.add_child(item)
			item.lab.text = "%s" % [dic["tile"]]
			item.id = id
			if modData.infoDs.has(id):
				item.pressed = modData.infoDs[id]




func _on_Button_pressed():
	var dic = {}
	for i in box.get_children():
		dic[i.id] = i.pressed
	modData.infoDs = dic
	modData.saveInfo()
	sys.newBaseMsg("提示", "需要重启生效！")
