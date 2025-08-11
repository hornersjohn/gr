extends "res://ui/msgBase/msgBase.gd"





onready var box = $ScrollContainer / GridContainer

var page = 1

func _ready():
	pass
	
func init():
	Steam.connect("ugc_query_completed", self, "ugc_query_completed")
	var bts = $VBoxContainer.get_children()
	bts = $HBoxContainer.get_children()
	for i in range(bts.size()):
		bts[i].connect("pressed", self, "pagePressed", [bts[i]])
	
	$HTTPRequest.connect("request_completed", self, "request_completed")
	popup()
	upPage(3, 7, 1)



var querH = 0
var maxPage = 0
var minPage = 1
var nowInx = 0
var nowInx2 = 0
func upPage(inx, inx2, page):
	Steam.releaseQueryUGCRequest(querH)
	nowInx = inx
	nowInx2 = inx2
	if inx2 == 0 and inx == 3: inx = 0
	if inx != 100:
		querH = Steam.createQueryAllUGCRequest(inx, 2, Steam.getAppID(), Steam.getAppID(), page)
	else:
		
		querH = Steam.createQueryUGCDetailsRequest(Steam.getSubscribedItems())
	Steam.setReturnLongDescription(querH, true)
	
	if inx2 != 0:
		Steam.setRankedByTrendDays(querH, inx2)
	Steam.sendQueryUGCRequest(querH)
	print("请求创意工坊")
	
func pagePressed(bt):
	upPage(nowInx, nowInx2, bt.text.to_int())

var dcs = []
func ugc_query_completed(a, b, c, d, e):
	calls.clear()
	dcs.clear()
	maxPage = ceil(d / c)
	var pageBtns = $HBoxContainer.get_children()
	for i in range(5):
		var m = 2
		if page == 1: m = 0
		if page == 2: m = 1
		var n = page + i - m
		if n > maxPage:
			pageBtns[i].hide()
		else:
			pageBtns[i].show()
			pageBtns[i].text = str(n)
	for i in box.get_children():
		i.free()
	for i in range(c):
		var dc = Steam.getQueryUGCResult(querH, i)
		dc["purl"] = Steam.getQueryUGCPreviewURL(querH, i)
		dc["title"] = dc["title"].to_ascii().get_string_from_utf8()
		dc["description"] = dc["description"].to_ascii().get_string_from_utf8()
		var item = preload("modSubItem.tscn").instance()
		box.add_child(item)
		item.init(dc)
		dc["item"] = item
		dcs.append(dc)
	Steam.releaseQueryUGCRequest(querH)
	print("创意工坊页面加载完毕")
	
	
func loadImg():
	for i in dcs:
		print("开始请求")
		$HTTPRequest.request(i["purl"])
		yield($HTTPRequest, "request_completed")
		print("收到图片")
		var image = Image.new()
		var error = null
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
				i["item"].texture = texture
				print("加载图片")
			
	









func _on_obt1_item_selected(id):
	upPage(nowInx, nowInx2, 1)

func _on_obt2_item_selected(id):
	upPage(nowInx, nowInx2, 1)

func _on_Button_pressed():
	upPage(100, 0, 1)

func _on_1_pressed():
	upPage(3, 7, 1)

func _on_2_pressed():
	upPage(3, 90, 1)

func _on_3_pressed():
	upPage(3, 0, 1)

func _on_4_pressed():
	upPage(1, 0, 1)

var headers
var body
func _on_HTTPRequest_request_completed(result, response_code, headers, body):
	self.headers = headers
	self.body = body

var calls = []
func _process(delta):
	if calls.size() > 0 and is_instance_valid(calls[0][0]):
		calls[0][0].request(calls[0][1])
		calls.remove(0)
