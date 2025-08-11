extends TextureButton




signal onLimg()

var inx = 0
var dc = null
var mas = null
onready var hq = $HTTPRequest


func _ready():
	mas = get_node("../../../")

func init(dc):
	$Label.text = dc["title"]
	self.dc = dc
	
	var file = File.new()
	var file_name = dc["purl"].replace("/", "+") + ".xx"
	file_name = file_name.replace(":", "`")
	if file.open(Steam.getAppInstallDir(Steam.getAppID()) + "/cache/" + file_name, File.READ) == OK:
		var infoDc = file.get_var(true)
		file.close()
		_on_HTTPRequest_request_completed( - 110, 0, infoDc["headers"], infoDc["body"])
	else:
		mas.calls.append([hq, dc["purl"]])



func _on_TextureButton_pressed():
	var msg = preload("modInfoMsg.tscn").instance()
	topUi.add_child(msg)
	msg.init(dc, self)

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
				var file_name = dc["purl"].replace("/", "+") + ".xx"
				file_name = file_name.replace(":", "`")
				if file.open(Steam.getAppInstallDir(Steam.getAppID()) + "/cache/" + file_name, File.WRITE) == OK:
					file.store_var(infoDs)
					file.close()

