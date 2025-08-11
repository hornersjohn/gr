extends Node
class_name Player

signal onPlusGold(val)
signal onSubGold(val)
signal onChangeGold()
signal onAddItem(item)
signal onDelItem(item)
signal onAddCha(cha)
signal onPlusLv()
signal onPlusEmp(val)
signal onAddTalent(talent)
signal onChangeHp(val)

var chas = []
var btChas = []
var items = []
var gold = 0
var renKou = 1
var renKouVal = 0
var maxHp = 100
var hp = maxHp
var lv = 1
var maxLv = 10
var emp = 0
var maxEmp = 0
var score = 0
var talentDs = {}

func _ready():
	upMaxEmp()

func addItem(item):
	items.append(item)
	emit_signal("onAddItem", item)
func delItem(item):
	items.erase(item)
	if item.masCha != null: item.masCha.delItem(item)
	emit_signal("onDelItem", item)

func addCha(cha):
	chas.append(cha)
	emit_signal("onAddCha", cha)
	return cha
	
func addBtChas(cha):
	btChas.append(cha)

func evoChara(cha, id):





	cha = sys.main.evoChara(cha, id)

	cha.isDrag = true
	cha.play("evo")

func plusGold(val):
	gold += val
	emit_signal("onPlusGold", val)
	emit_signal("onChangeGold")
	audio.playSe("gold")

func subGold(val):
	if gold >= val:
		gold -= val
		emit_signal("onSubGold", val)
		emit_signal("onChangeGold")
		return true
	else: return false

func plusEmp(val):
	if lv >= maxLv: return false
	emp += val
	var bl = false
	while emp >= maxEmp:
		emp -= maxEmp
		plusLv(1)
		bl = true
	emit_signal("onPlusEmp", val)
	if bl:
		sys.newBaseMsg("角色升级", tr("你升级了，人口提升！"))
	return bl
	
func plusLv(val):
	lv += 1
	renKou = lv
	upMaxEmp()
	emit_signal("onPlusLv")

func upMaxEmp():
	
	maxEmp = 30 + (60 * (lv - 1))

func addTalent(tal):
	talentDs[tal.id] = tal
	tal.setPlayer(self)
	emit_signal("onAddTalent", tal)
	
func delTalent(tal):
	talentDs.erase(tal.id)
	tal.del()
	
func plusHp(val):
	hp += val
	if hp > maxHp:
		hp = maxHp
	emit_signal("onChangeHp", val)
	
func subHp(val):
	hp -= val
	if hp < 0:
		hp = 0
	emit_signal("onChangeHp", val)

func infoGet():
	var items = []
	var cha1s = []
	var cha2s = []
	var tals = []
	
	for i in self.items:
		var dic = {
			id = i.id
		}
		items.append(dic)
	
	for i in self.talentDs.values():
		var dic = {
			id = i.id, 
			lv = i.lv
		}
		tals.append(dic)
		
	for i in sys.main.map.get_children():
		if i is Chara and i.team == 1 and i.isSumm == false:
			var itemIds = []
			for j in i.items:
				itemIds.append(self.items.find(j))
			var dic = {
				id = i.id, 
				cell = [i.cell.x, i.cell.y], 
				hp = i.att.hp / i.att.maxHp, 
				itemIds = itemIds
			}
			cha1s.append(dic)
		
	for i in sys.main.btGrid.get_children():
		var cha: Chara = i.get_child(0)
		var itemIds = []
		for j in cha.items:
			itemIds.append(self.items.find(j))
		var dic = {
			id = cha.id, 
			hp = cha.att.hp / cha.att.maxHp, 
			itemIds = itemIds
		}
		cha2s.append(dic)
		
	var dic = {
		gold = gold, 
		renKou = renKou, 
		hp = hp, 
		lv = lv, 
		maxLv = maxLv, 
		emp = emp, 
		items = items, 
		tals = tals, 
		cha1s = cha1s, 
		cha2s = cha2s, 
		jlv = jinJieData.nowLv, 
		batLLv = sys.main.batLLv, 
		rndPoolRsl = chaData.rndPoolRsl, 
		itemRndPoolRsl = itemData.rndPoolRsl
	}
	return dic
	
func infoSet(dic):
	gold = dic["gold"]
	renKou = dic["renKou"]
	
	hp = dic["hp"]
	maxLv = dic["maxLv"]
	emp = dic["emp"]
	jinJieData.nowLv = dic["jlv"]
	sys.main.batLLv = dic["batLLv"]
	chaData.rndPoolRsl = dic["rndPoolRsl"]
	itemData.rndPoolRsl = dic["itemRndPoolRsl"]
	for i in range(dic["lv"] - 1):
		plusLv(1)
	
	for i in dic["items"]:
		addItem(sys.newItem(i["id"]))
	
	for i in range(dic["tals"].size()):
		var tal = sys.newTalent(dic["tals"][i]["id"])
		tal.lv = dic["tals"][i]["lv"]
		sys.main.playerPan.get_node("GridContainer").get_child(i).xueXi(tal)
	
	for i in dic["cha1s"]:
		var cha: Chara = sys.main.newChara(i["id"], 1)
		sys.main.map.add_child(cha)
		cha.cell = Vector2(i["cell"][0], i["cell"][1])
		cha.setCell(cha.cell)
		
		cha.isDrag = true
		cha.isItem = false
		for j in i["itemIds"]:
			sys.main.itemSetCha(sys.main.itemGrid.get_child(int(j)), cha)
		
		cha.att.hp = cha.att.maxHp * i["hp"]
		cha.plusHp(0.1)
		
	for i in dic["cha2s"]:
		var cha = addCha(sys.main.newChara(i["id"], 1))
		for j in i["itemIds"]:
			sys.main.itemSetCha(sys.main.itemGrid.get_child(int(j)), cha)
		cha.att.hp = cha.att.maxHp * i["hp"]
		cha.plusHp(0.1)
	sys.main.upLv()

