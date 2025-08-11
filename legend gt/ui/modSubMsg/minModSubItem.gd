extends ImgBtn



signal onLimg()
var item = null
var mas = null


func _ready():
	pass

func init(item, mas):
	self.mas = mas
	self.item = item
	$Label.text = item.tile
	if item.img == "": return
	var file = File.new()
	var file_name = item.img.replace("/", "+") + ".xx"
	file_name = file_name.replace(":", "`")
	if file.open("user://cache/" + file_name, File.READ) == OK:
		var infoDc = file.get_var(true)
		file.close()
		_on_HTTPRequest_request_completed( - 110, 0, infoDc["headers"], infoDc["body"])
	else:
		pass
		$HTTPRequest.request(item.img)
	upBtn()
	connect("onPressed", self, "_on_TextureButton_pressed")
		
func upBtn():
	var st = ifDown()
	$CheckBox.hide()
	if st == 0:
		$Label2.text = ""
	elif st == 2:
		$Label2.text = "可更新"
	else:
		$Label2.text = "已下载"
		if mas.sel == 3:
			$CheckBox.show()
			$CheckBox.pressed = item.sel

func _on_TextureButton_pressed():
	var msg = sys.newMsgL("modSubMsg/minModInfoMsg")
	msg.init(self)

func _on_HTTPRequest_request_completed(result, response_code, headers, body):
	var image = Image.new()
	var error = null
	if headers.size() < 2: return
	if headers[1] == "Content-Type: image/jpeg":
		error = image.load_jpg_from_buffer(body)
	elif headers[1] == "Content-Type: image/png":
		error = image.load_png_from_buffer(body)
	if error != null:
		if error != OK:
			pass
		else:
			var texture = ImageTexture.new()
			texture.create_from_image(image)
			$Sprite.texture = texture
			emit_signal("onLimg")
			if result != - 110:
				var file = File.new()
				var infoDs = {
					headers = headers, 
					body = body
				}
				var file_name = item.img.replace("/", "+") + ".xx"
				file_name = file_name.replace(":", "`")
				if file.open("user://cache/" + file_name, File.WRITE) == OK:
					file.store_var(infoDs)
					file.close()

func ifDown():
	var file = File.new()
	if file.open("user://pcks/%s.pck" % item._id, File.READ) == OK:
		file.close()
		file.open("user://pcks/%s.info" % item._id, File.READ)
		var ib = file.get_var()
		file.close()
		if ib.pckTime == item.pckTime:
			return 1
		return 2
	return 0

func _on_CheckBox_pressed():
	item.sel = $CheckBox.pressed
	var file = File.new()
	file.open("user://pcks/%s.info" % item._id, File.WRITE)
	file.store_var(item)
	file.close()
	sys.newBaseMsg("提示", "需要重启生效！")
