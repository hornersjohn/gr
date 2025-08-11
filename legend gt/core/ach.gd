class_name Ach

var player: Player = null
signal changeLv()

func setPlayer(player):
	self.player = player
	_connect()

signal onDel()

var Cname = "Buff"
var id = "default"
var name = ""
var info = "" setget set_info, get_info
var tab = ""
var lv = 0 setget set_lv

func _init():
	init()
	var fname = get_script().resource_path.split("/")
	id = fname[fname.size() - 1].split(".")[0]
	Cname = "Talent"
func init():
	pass

func _connect():
	pass
	
func delConnect():
	for i in get_incoming_connections():
		i["source"].disconnect(i["signal_name"], self, i["method_name"])
		
func _getInfo():
	return info

func set_lv(val):
	lv = val
	emit_signal("changeLv")

var time = 0















				
func _process(delta):
	pass
	
func _upS():
	pass
	
func del():
	delConnect()
	_del()
	emit_signal("onDel")
	
func _del():
	pass

func set_info(val):
	info = val
func get_info():
	return info
