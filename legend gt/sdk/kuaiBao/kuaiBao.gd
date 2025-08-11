extends Node
var hc = HTTPClient.new()

var key = ""
var msg = null
var jihuoBtn = false
var info = null

func _ready():
	yield(sys, "onStart")
	$CanvasLayer / logo / AnimationPlayer.play("idle")
	
	
func jiHuo(key):
	self.key = key
	var ts = OS.get_unix_time()
	var device1 = OS.get_unique_id()
	var device = ""
	for i in device1:
		if i != "{" and i != "}" and i != "-":
			device += i
	var ds = {
		ac = "checkkey", 
		ts = ts, 
		key = key, 
		gid = "130473", 
		secure = "885a186b544c4001adaad2acde752e7c", 
		device = device, 
		token = ("#kb2%s|%s$" % [ts, key]).md5_text()
		
	}
	info = ds
	post("http://huodong.4399.com/hykb/admincdkey/codesapi.php", ds)
	
func post(url: String, dic_data: Dictionary, use_ssl: bool = true):
	
	var query_string = hc.query_string_from_dict(dic_data)
	
	
	var headers = ["Content-Type: application/x-www-form-urlencoded"]
	
	
	
	
	
	$HTTPRequest.request(url, headers, use_ssl, HTTPClient.METHOD_POST, query_string)
	
	
func _on_HTTPRequest_request_completed(result, response_code, headers, body):
	if result != 0:
		sys.newBaseMsg("错误", "网络链接错误！")
		return
	var ds = str2var(body.get_string_from_utf8())
	
	if ds.code == 100:
		if jihuoBtn:
			sys.newBaseMsg("激活码", codeDs[ds.code])
		geng()
		if msg != null:
			msg.queue_free()
			saveInfo()
	else:
		sys.newBaseMsg("激活码", codeDs[ds.code])
	
func loadInfo():
	var file = File.new()
	if file.open("user://kuaiBao.save", File.READ) == OK:
		var dic = parse_json(file.get_line())
		file.close()
		if dic.has("key"):
			key = dic["key"]
			jiHuo(key)
		return dic
	
func saveInfo():
	var file = File.new()
	var dir = Directory.new()
	var dic = {
		key = key
	}
	file.open("user://kuaiBao.save", File.WRITE)
	file.store_line(to_json(dic))
	file.close()

func geng():
	var url = "https://huodong3.3839.com/hykb/gave/api/ApiGameActionV2.php"
	var headers = ["Content-Type: application/x-www-form-urlencoded"]
	var ts = OS.get_unix_time()
	var ds = {
		gameid = "125577", 
		ac = "readgameversion", 
		ts = ts, 
		token = ("#%s&%s*%s|" % ["125577", "4399Efgh99d313G1", ts]).md5_text()
	}
	var query_string = hc.query_string_from_dict(ds)
	$HTTPRequest2.request(url, headers, true, HTTPClient.METHOD_POST, query_string)

func _on_HTTPRequest2_request_completed(result, response_code, headers, body):
	if result != 0:
		sys.newBaseMsg("错误", "网络链接错误！")
		return
	var ds = str2var(body.get_string_from_utf8())
	if ds.code == "100":
		var re = ds.result
		if re.last_client_version.to_float() > sys.v.to_float() and re.force_update != "-1":
			var msg = preload("gengXin.tscn").instance()
			topUi.add_child(msg)
			msg.init(re.tiptxt, re.download_url, re.force_update)
	else:
		sys.newBaseMsg("", codeDs2[ds.code])

var codeDs = {
	100: "验证成功", 
	101: "请求过期，请尝试校准你的手机时间。", 
	102: "token错误，请重试！", 
	103: "激活码格式错误", 
	104: "激活码不存在或类型错误", 
	105: "激活码维护中", 
	106: "激活码尚未开启", 
	107: "激活码已过期", 
	108: "激活码已被使用", 
	109: "服务器开小差了，请重试！", 
	110: "请求非法", 
	111: "激活码编号不能为空", 
	112: "游戏id或激活码编号错误", 
	113: "", 
	114: "激活码验证中，请稍后", 
	115: "激活码不存在", 
	116: "设备号为空或格式错误", 
}

var codeDs2 = {
	100: "验证成功", 
	99: "参数错误", 
	98: "token匹配错误", 
	97: "查询方法错误", 
	96: "未查询到数据", 
}

func _on_AnimationPlayer_animation_finished(anim_name):
	$CanvasLayer / logo.queue_free()
	var jk = preload("res://sdk/jianKang.tscn").instance()
	$CanvasLayer.add_child(jk)
	yield(jk.get_node("AnimationPlayer"), "animation_finished")
	loadInfo()
	sys.newMsg("gongGaoMsg")




