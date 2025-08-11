extends Node

class Info:
	var id = ""
	var lv = 1
	var dir = ""
	var hide = false
	
var infoDs = {}
var infos = []
var rndPool: = RndPool.new()

func _ready():
	pass
















func loadInfo(dname, dir):
	var info = Info.new()
	info.id = dname
	infos.append(info)
	infoDs[info.id] = info
	info.dir = dir
	if info.id.find("Hide") != - 1: info.hide = true
	
	
var rndPoolRsl = []
func rndPoolRs():
	rndPool.clear()
	for i in rndPoolRsl:
		rndPool.addItem(infoDs[i], 1)
