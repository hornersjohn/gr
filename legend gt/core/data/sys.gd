extends Node
signal onStart()

var main: Main = null
var objPool = []
var player = null
var ui = null

var test = OS.has_feature("editor")
var testLog = null
var isMin = false
var isDemo = false
var isSteam = true
var quDao = "steam"
var sel_num = 6
var sel_item_num = 30
var godotSteam = null
var v = 1.03
var adSdk = null
var tileNum = 0

var uiVs = 3

var resPool = {}

func _init():
	randomize()

func _ready():
	var osName = OS.get_name()
	if osName == "Windows":
		quDao = "steam"
	else:
		quDao = "kuaiBao"
	ui = CanvasLayer.new()
	testLog = preload("res://test.tscn").instance()
	var cl = CanvasLayer.new()
	add_child(cl)
	cl.layer = 100
	cl.add_child(testLog)
	
	
	OS.center_window()
	print(osName)
	if quDao == "kuaiBao":
		isMin = true
	elif quDao == "steam":
		isMin = false
	elif quDao == "a":
		isMin = true
	
	if isMin:
		var dir = Directory.new()
		dir.make_dir_recursive("user://cache/")
		dir.make_dir_recursive("user://pcks")
		if Engine.has_singleton("CenterControl"):
			adSdk = Engine.get_singleton("CenterControl")
			adSdk.connect("onError", self, "adError")
			
	if OS.has_feature("editor") or isMin == true or sys.isDemo or not sys.isSteam:
		pass
	else:
		godotSteam = load("res://godotSteam/godotsteam.gd").new()
		godotSteam.init()
	loadInfo()
	
	if quDao == "kuaiBao":
		sys.add_child(preload("res://sdk/kuaiBao/kuaiBao.tscn").instance())
	
	var logo = preload("res://start/logo.tscn").instance()
	start.add_child(logo)
	yield(logo.get_node("AnimationPlayer"), "animation_finished")
	emit_signal("onStart")
	
func adPlay():
	adSdk.test("hi,android")
	print("请求视频")
	return true

func adError():
	OS.alert("请求视频失败")
		
func _input(event):
	if event.is_action_pressed("ui_down"):
		testLog.visible = not testLog.visible
		
	if event is InputEventScreenTouch:





		sys.lastInPanExit()
		pass

func _process(delta):
	if godotSteam != null:
		godotSteam._process(delta)
	
func p(txt):
	testLog.p(txt)
		

func rndPer( var val):
	if randi() % 100 < val:
		return true
	return false

func rndRan(mmin, mmax):
	return randi() % (mmax - mmin + 1) + mmin

func rnd(val):
	return randi() % val

func rndListItem(list):
	if list.size() > 0:
		return list[rnd(list.size())]
	return null

func newEff(name, pos, isUi = false, dire = - 1):
	var map = main.map
	var node = load("res://ex/eff/%s.tscn" % name).instance()
	if isUi:
		map.get_node("../uiLayer").add_child(node)
	else:
		map.add_child(node)
	if sys.isClass(node, "Obj"): node.dire = dire
	else: node.scale.x = dire
	node.position = pos
	return node
	
func newItem(id):
	var item = null
	item = load("{dir}/{id}/{id}.gd".format({id = id, dir = itemData.infoDs[id].dir})).new()
	return item
	
func newTalent(id):
	var item = load("{dir}/{id}/{id}.gd".format({id = id, dir = talentData.infoDs[id].dir})).new()
	return item
	

func newMsg(name):
	var msg = load("res://ui/{name}/{name}.tscn".format({name = name})).instance()
	topUi.add_child(msg)
	return msg

func newMsgL(name):
	var msg = load("res://ui/{name}.tscn".format({name = name})).instance()
	topUi.add_child(msg)
	return msg


func newBaseMsg(tile, info):
	var msg = preload("res://ui/msgBox/msgBox.tscn").instance()
	topUi.add_child(msg)
	msg.init(tile, info)
	return msg

func delObj(obj):
	objPool.append(obj)
	
func getObj(fileName):
	for i in range(objPool.size()):
		if objPool[i].filename == fileName:
			var obj = objPool[i]
			objPool.remove(i)
			return obj
	return null
		
func cameraShake(uration, frequency, amplitude):
	if notNull(sys.main.cam):
		sys.main.cam.shake(uration, frequency, amplitude)
	
func notNull(obj):
	if obj == null: return false
	elif not weakref(obj).get_ref(): return false
	return true
	
func isClass(obj, className):
	if notNull(obj) == false: return false
	var s = obj.get("className")
	if s == null: return false
	elif s == className: return true
	return false
	
func delEff(pos, dire):
	yield(get_tree().create_timer(0.01), "timeout")
	if notNull(player): player.se("hit2")
	sys.cameraShake(0.25, 60, 2)
	for i in range(3):
		
		pass
	
func saveInfo():
	pass
	
func loadInfo():
	audio.loadInfo()
	jinJieData.loadInfo()
	modData.loadInfo()
	loadEx("res://ex/chara")
	loadEx("res://ex/item")
	loadEx("res://ex/talent")
	
	if isMin: minLoadInfo()
	
	
	if godotSteam != null:
		sys.godotSteam.loadMod()
	chaData.init()

func loadEx(dirStr):
	var dir = Directory.new()
	dir.open(dirStr)
	dir.list_dir_begin()
	var file = File.new()
	var dname = dir.get_next()
	while dname != "":
		if dir.current_is_dir() and dname != "core":
			if dirStr.left(4) == "res:" and ResourceLoader.exists("%s/%s/%s.gd" % [dirStr, dname, dname]) == false:
				dname = dir.get_next()
				continue
			if dirStr.left(4) != "res:" and file.open("%s/%s/%s.gd" % [dirStr, dname, dname], File.READ) != OK:
				dname = dir.get_next()
				continue
			file.close()
			if dname[0] == "c":
				chaData.loadInfo(dname, dirStr)
			elif dname[0] == "i":
				itemData.loadInfo(dname, dirStr)
			elif dname[0] == "t":
				talentData.loadI(dname, dirStr)
			elif dname[0] == "g":
				globalData.loadInfo(dname, dirStr)
		dname = dir.get_next()
	dir.list_dir_end()

func minLoadInfo():
	var dir = Directory.new()
	var dirStr = "user://pcks/"
	dir.open(dirStr)
	dir.list_dir_begin()
	var dname = dir.get_next()
	while dname != "":
		if not dir.current_is_dir() and dname.get_extension() == "pck":
			var file = File.new()
			file.open("user://pcks/%s.info" % dname.get_basename(), File.READ)
			var ib = file.get_var()
			file.close()
			if ib.sel == false:
				ProjectSettings.load_resource_pack(dirStr + dname, false)
		dname = dir.get_next()
	dir.list_dir_end()
	
	minLoadMods("res://mods/")
	
func minLoadMods(dirStr):
	var dir = Directory.new()
	if dir.open(dirStr) == OK:
		dir.list_dir_begin()
		var dname = dir.get_next()
		while dname != "":
			if dir.current_is_dir():
				loadEx(dirStr + dname)
			dname = dir.get_next()
		dir.list_dir_end()
	else:
		print("无" + dirStr)
		
func showDirs(dirStr):
	var dir = Directory.new()
	if dir.open(dirStr) == OK:
		dir.list_dir_begin()
		var dname = dir.get_next()
		while dname != "":
			print(dname)
			dname = dir.get_next()
		dir.list_dir_end()
	else:
		print("无" + dirStr)

signal onChangeLastInPan(old, now)
var lastInPan: Array = []
func addLastInPan(val):
	if lastInPan.size() == 0 or lastInPan[lastInPan.size() - 1] != val:
		lastInPanExit()
		lastInPan.append(val)
		val.enter()
func lastInPanExit():
	for i in lastInPan:
		if is_instance_valid(i): i.exit()
	lastInPan.clear()
func delLastInPan():
	if isMin == false:
		lastInPanExit()
		
func getFormJson(filename):
	var file = File.new()
	file.open(filename, File.READ)
	var text = file.get_as_text()
	var data = parse_json(text)
	file.close()
	return data
