extends Reference
class_name RndPool

var items = []
var weight = 0

func _init(ss = null):
	if ss != null:
		reSetItems(ss)

func reSetItems(ss):
	items.clear()
	weight = 0
	for i in ss:
		addItem(i[0], i[1])
	pass
	
func getItemW(item):
	for i in items:
		if i[0] == item: return i[1]
	
func addItem(item, weight):
	items.append([item, weight])
	self.weight += weight

func rndItem(obj = null, funcName = null):
	if obj == null:
		var r = rand_range(0, weight)
		var s = 0
		for i in range(items.size()):
			s += items[i][1]
			if s >= r:
				return items[i][0]
		return null
	else:
		var ls = []
		var w = 0
		for i in items:
			if obj.call(funcName, i[0]):
				ls.append(i)
				w += i[1]
		var r = rand_range(0, w)
		var s = 0
		for i in range(ls.size()):
			s += ls[i][1]
			if s >= r:
				return ls[i][0]
		return null

func clear():
	items.clear()
	weight = 0
