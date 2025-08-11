extends Node

signal changeP()

class Info:
	var id = ""
	var lv = 0
	var dir
	
var infoDs = {}
var infos = []
var rndPool: = RndPool.new()

var lvP = [200, 400, 700, 1300, 2000]
var p = 200

func _ready():
	pass












	loadInfo()
	
func subP(val):
	if p >= val:
		p -= val
		emit_signal("changeP")
		return true
	else: return false
	
func plus(val):
	if sys.test == false: p += val
	emit_signal("changeP")
	
func loadI(dname, dir):
	var info = Info.new()
	info.id = dname
	info.dir = dir
	infos.append(info)
	infoDs[info.id] = info
	rndPool.addItem(info, 1)

func loadInfo():
	var file = File.new()
	if file.open("user://data1/talent.save", File.READ) == OK:
		var dic: Dictionary = parse_json(file.get_line())
		file.close()
		if dic == null: print_debug("读取存档错误")
		var kl = dic.keys()
		var vl = dic.values()
		for i in kl:
			if i != "p":
				if infoDs.has(i):
					infoDs[i].lv = dic[i]
		if dic.has("p"): self.p = dic["p"]
		
		file.close()
		return dic
	
func saveInfo():
	var file = File.new()
	var dir = Directory.new()
	dir.make_dir_recursive("user://data1/")
	var dic = {}
	dic["p"] = p
	for i in infos:
		dic[i.id] = i.lv
	file.open("user://data1/talent.save", File.WRITE)
	file.store_line(to_json(dic))
	file.close()
