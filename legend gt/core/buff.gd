class_name Buff

signal onDel()
signal onSetCha()

var Cname = "Buff"
var id = "default"
var name = ""
var info = ""
var tab = ""
var life = null
var lv = 0
var pw = 1.0
var noLife = false
var isDel = false
var masCha = null
var casCha = null
var att: Att = null
var eff: Node2D = null
var effId = ""
var isNegetive = false
var direc = ""
	
func _init():
	init()
	var ss = get_script().resource_path
	var fname = ss.split("/")
	id = fname[fname.size() - 1].split(".")[0]
	direc = ss.left(ss.length() - id.length() - 3)
func init():
	pass

func setCha(masCha, casCha = null):
	self.masCha = masCha
	if casCha == null:
		self.casCha = masCha
	_connect()
	if effId != "" and eff == null:
		eff = load("res://ex/eff/%s.tscn" % effId).instance()
		masCha.get_node("spr/normal").add_child(eff)
		eff.position += masCha.sprcPos + Vector2(0, 30)
	emit_signal("onSetCha")

func attInit():
	att = Att.new()

func _connect():
	pass
	
func delConnect():
	for i in get_incoming_connections():
		i["source"].disconnect(i["signal_name"], self, i["method_name"])
		
func _getInfo():
	return info

var time = 0
func process(delta):
	if isDel == false:
		if life != null and noLife == false:
			var oldLife = int(life)
			life -= delta
			if oldLife != int(life):
				_upS()
			if life <= 0:
				isDel = true
		else:
			time += delta
			if time >= 1:
				time -= 1
				_upS()
	_process(delta)
				
func _process(delta):
	pass
	
func _upS():
	pass
	
func del():
	if eff != null: eff.queue_free()
	delConnect()
	_del()
	emit_signal("onDel")
	
func _del():
	pass
