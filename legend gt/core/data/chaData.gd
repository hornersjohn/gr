extends Node

class Info:
	var id = ""
	var base = null
	var evos = []
	var lv = 1
	var dir = ""
	var hide = false
	
var infoDs = {}
var infos = []
var infosLv4 = []
var rndPool: = RndPool.new()
var rndPoolRal = []
var rndPoolRsl = []

func _ready():
	pass
	
			
func init():
	var rd = [9, 3, 1, 0]
	for i in infos:
		for j in infos:
			if i.lv - j.lv == 1 and i.id.find(j.id) != - 1 and i.dir == j.dir:
				i.base = j
				j.evos.append(i)
		infoDs[i.id] = i
		if i.hide == false:
			rndPool.addItem(i, rd[i.lv - 1])
				
			if i.id.find("_") == - 1:
				rndPoolRal.append(i.id)

func rndPoolRs():
	rndPool.clear()
	infosLv4.clear()
	







	
	var rd = [9, 3, 1, 0]
	for i in infos:
		var bl = false
		var istr = i.id
		for j in rndPoolRsl:
			if i.dir == infoDs[j].dir and (istr.find(j) != - 1 or (istr.find("cex") != - 1 and istr.find(j.right(1)) != - 1)):
				bl = true
				break
		if bl:
			rndPool.addItem(i, rd[i.lv - 1])
			if i.lv > 3: infosLv4.append(i)
	pass
















	
func loadInfo(dname, dir):
	var info = Info.new()
	info.id = dname
	info.lv = info.id.split("_").size()
	if info.lv == 0: info.lv = 1
	info.dir = dir
	if info.id.find("Hide") != - 1: info.hide = true
	infos.append(info)
	
func getBaseId(id):
	if infoDs[id].base != null:
		return infoDs[id].base.id
	else: return id
	
func getLvIds(id, lv):
	var info = infoDs[id]
	while info.base != null and info.id != "" and info.lv > lv:
		info = info.base
	if info.id == "": info.id = "c1"
	return info.id
	
func getEvoIds(id):
	var ids = []
	for i in infoDs[id].evos: ids.append(i.id)
	return ids

var lv = 0
func rndLvInfo(lv):
	self.lv = lv
	return rndPool.rndItem(self, "isLv")
func isLv(obj):
	if obj.lv == lv: return true
	return false
