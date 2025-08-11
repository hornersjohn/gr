extends "res://ui/msgBase/msgBase.gd"





var mas = null


func _ready():
	pass

func init(mas):
	$Label.text = mas.item.tile
	$RichTextLabel.bbcode_text = mas.item.dec
	self.mas = mas
	l()
	mas.connect("onLimg", self, "l")
	popup()
	upBtn()

func upBtn():
	var st = mas.ifDown()
	$Button.disabled = false
	$Button2.hide()
	if st == 0:
		$Button.text = "下载"
	elif st == 2:
		$Button.text = "更新"
	else:
		$Button.text = "已下载"
		$Button.disabled = true
		$Button2.show()
		
	mas.upBtn()
	
func l():
	$TextureRect.texture = mas.get_node("Sprite").texture
var msg = null
func _on_Button_pressed():
	var st = mas.ifDown()
	if st != 1:
		if mas.item.pck != "":
			$HTTPRequest.request(mas.item.pck)
			msg = sys.newMsgL("modSubMsg/minModDown")
			msg.item = mas.item
			msg.hq = $HTTPRequest
			if st == 0:
				msg.init("正在下载，请等待")
			elif st == 2:
				msg.init("正在更新，请等待")
			yield($HTTPRequest, "request_completed")
			if st == 0: msg.end("下载完成，需要重启游戏才会加载该Mod", st)
			else: msg.end("更新完成，需要重启游戏才会加载该Mod", st)
			upBtn()
		else:
			sys.newBaseMsg("", "该Mod作者未上传资源")
	else:
		sys.newBaseMsg("", "已经下载")
	pass

func _on_HTTPRequest_request_completed(result, response_code, headers, body):
	if result != 0:
		sys.newBaseMsg("错误", "网络链接错误！")
		if is_instance_valid(msg):
			msg.get_node("Label").text = "下载失败"
		return
	var dir = Directory.new()
	dir.remove("user://pcks/%s.info" % mas.item._id)
	dir.remove("user://pcks/%s.pck" % mas.item._id)
	var file = File.new()
	file.open("user://pcks/%s.pck" % mas.item._id, File.WRITE)
	file.store_buffer(body)
	file.close()
	mas.item["sel"] = false
	file.open("user://pcks/%s.info" % mas.item._id, File.WRITE)
	file.store_var(mas.item)
	file.close()

func _onDel_pressed():
	var dir = Directory.new()
	dir.remove("user://pcks/%s.info" % mas.item._id)
	dir.remove("user://pcks/%s.pck" % mas.item._id)
	sys.newBaseMsg("", "删除成功,需要重启才能正常游戏！")
	mas.mas.upPage(1)
	queue_free()
