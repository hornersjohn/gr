extends "res://ui/msgBase/msgBase.gd"





onready var box = $ScrollContainer / GridContainer


func _ready():
	pass



var sel = 1
var page = 1
var newPage = 0

func init():
	var bts = $VBoxContainer.get_children()
	popup()
	
	upPage(1)

func upPage(inx):
	if inx == 0:
		sys.newBaseMsg("提示", "已经第一页")
		return
	newPage = inx
	inx = inx - 1
	if sel == 3:
		upMyItems()
		return
	var url = "https://lc-3gbiznhs83f8175f-1302941602.ap-shanghai.service.tcloudbase.com/getItems"
	if sel == 2:
		url = "https://lc-3gbiznhs83f8175f-1302941602.ap-shanghai.service.tcloudbase.com/getItemsL"
	url += "?inx=%d" % inx
	var error = $HTTPRequest.request(url)
	
	
	sys.p(url)
	
func pagePressed(bt):
	upPage(bt.text.to_int())

func _on_1_pressed():
	sel = 1
	upPage(1)

func _on_2_pressed():
	sel = 2
	upPage(1)
	
var items = []
func _on_HTTPRequest_request_completed(result, response_code, headers, body):
	if result != 0:
		sys.newBaseMsg("错误", "网络链接错误！")
		return
	var items = str2var(body.get_string_from_utf8())
	if items.size() == 0:
		sys.newBaseMsg("提示", "已经最后一页")
		return
	self.items = items
	for i in box.get_children():
		i.free()
	for i in items:
		var item = preload("minModSubItem.tscn").instance()
		box.add_child(item)
		if i.has("sel") == false:
			i["sel"] = false
		item.init(i, self)
	page = newPage
	$page / Label.text = str(page)

func _on_p1_pressed():
	upPage(page - 1)

func _on_p2_pressed():
	upPage(page + 1)

func _on_my_pressed():
	sel = 3
	upPage(1)
	
func upMyItems():
	for i in box.get_children():
		i.free()
	var dir = Directory.new()
	var dirStr = "user://pcks/"
	if dir.open(dirStr) == OK:
		dir.list_dir_begin()
		var dname = dir.get_next()
		while dname != "":
			if dir.current_is_dir() == false and dname.get_extension() == "info":
				var file = File.new()
				if file.open(dirStr + dname, File.READ) == OK:
					var item = file.get_var()
					file.close()
					var itemBtn = preload("minModSubItem.tscn").instance()
					box.add_child(itemBtn)
					itemBtn.init(item, self)
			dname = dir.get_next()
	dir.list_dir_end()

func _on_popup_hide():
	queue_free()
	pass
