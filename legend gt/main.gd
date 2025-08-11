extends Node2D
class_name Main

signal onBattleEnd()
signal onBattleStart()
signal onCharaDel(cha)
signal onCharaCastCdSkill(cha, id)
signal onCharaNewChara(cha)
signal onCharaHurt(atkInfo)
signal onCharaAddBuff(buff)
signal onPlaceChara(cha)
signal onPlaceItem(item)
signal onBattleReady()
signal onSureEvo()
signal onAddBatChara(cha)
signal onItemIn(item)
signal onTongGuan(lv)
signal onBossEnd(lv)
signal onEvo(cha)


onready var scene = $scene
onready var map: TileMap = $scene / TileMap
var cam = null
var mat = []
var nowCell = Vector2(1, 2)
var isAiStart = false
var isTest = false
var num = 100
var matH = 6
var matW = 10

var lv = 0
var chaPool = RndPool.new()
var charaRs = []

onready var player: Player = $players / player
onready var guanKaBtn: = $ui / guanKa / Button
onready var playerPan: = $ui / player
onready var btGrid: = $ui / Panel / ScrollContainer / GridContainer
onready var itemGrid: = $ui / itemSll / itemGrid
var tw = null
var aStar = AStar2D.new()
var guankaMsg = null
var dpsMsg = null
var jinJie = null
var ach = null

func _ready():
	if sys.isMin == false:
		itemGrid.columns = 6
	
	tw = Tween.new()
	add_child(tw)
	tw.interpolate_property(self, "modulate", Color("00ffffff"), Color("ffffff"), 0.5, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tw.start()
	if sys.test: $ui / optionBtn2.show()
	else: $ui / optionBtn2.hide()


	guankaMsg = sys.newMsg("guanKaMsg")
	dpsMsg = sys.newMsg("dpsMsg")
	audio.playBgm("map")
	guanKaBtn.connect("pressed", self, "_on_guanKa_pressed")
	ach = preload("res://ex/ach/tongGuan0.gd").new()
	ach.setPlayer(player)
	player.connect("onAddItem", self, "addItem")
	player.connect("onAddCha", self, "_onAddCha")
	player.connect("onPlusGold", self, "_onChangeGold")
	player.connect("onSubGold", self, "_onChangeGold")
	player.connect("onPlusEmp", self, "upLv")
	player.connect("onDelItem", self, "_onDelItem")
	guanKaBtn.setMap()
	$ui / player.init(player)
	
	for x in range(matW):
		var vx = []
		mat.append(vx)
		for y in range(matH):
			vx.append(null)
			aStar.add_point(cellToId(Vector2(x, y)), Vector2(x, y))
	
	for x in range(matW):
		for y in range(matH):
			for i in sizCells:
				var cell = Vector2(x, y)
				var nCellId = cellToId(i + cell); var cellId = cellToId(cell)
				if isMatin(i + cell): aStar.connect_points(cellId, nCellId);
	
	



var mode = 0
func init(mode = 0):
	self.mode = mode
	if mode == 1:
		guankaMsg.maxLLv = 6
		player.maxLv = 15
	sys.newMsg("startItemMsg").init()
	sys.newMsg("startMsg").init()
			
func initSt():
	chaData.rndPoolRs()
	itemData.rndPoolRs()
	guankaMsg.init()
	for i in range(4 + jinJieData.nowLv):
		player.addCha(newChara(chaData.rndLvInfo(1).id))
	
	player.plusGold(50)
	player.addItem(sys.newItem(itemData.rndPool.rndItem().id))
	
	upLv()
	if sys.test:






		player.addCha(newChara("cex___7"))
		player.addCha(newChara("ca2"))
		player.addCha(newChara("ca2_1"))
		player.addCha(newChara("ca2_1_1"))
		player.addCha(newChara("ca2_1_2"))
		player.addCha(newChara("ca2_2"))
		player.addCha(newChara("ca2_2_1"))
		player.addCha(newChara("ca2_2_2"))
		player.addCha(newChara("cex___a2"))
		
		for i in itemData.infos:
			player.addItem(sys.newItem(i.id))
		

func cellToId(cell): return cell.x + cell.y * matW;
func idToCell(id): return Vector2(id % matW, id / matW)

var rndLv = 1
func rndInfo():
	return chaData.rndPool.rndItem(self, "rndF")
func rndF(obj):
	if rndLv >= 20:
		if chaData.rndPool.getItemW(obj) == 1:
			return true
	elif rndLv >= 3:
		if chaData.rndPool.getItemW(obj) == 3:
			return true
	elif rndLv < 3:
		return true
	else: return false

var batChas = []
var batType = 0
var batLv = 1
var batLLv = 0

func battleReady(lvcs, lvzb, batType):
	batChas = lvcs
	self.batType = batType
	chaPool.clear()
	var dChas = []
	var yl = [1, 4, 0, 5, 2, 3]
	var llp = [9, 3, 1, 0]
	for i in lvcs:
		var cha = newChara(i, 2)
		map.add_child(cha)
		var bl = false
		for y in yl:
			for x in range(cha.att.atkRan - 1 + matW / 2, matW):
				if matCha(Vector2(x, y)) == null:
					setMatCha(Vector2(x, y), cha)
					bl = true;break
			if bl: break
		if matCha(cha.cell) != null and cha.cell != Vector2():
			cha.setDire( - 1)
			cha.isDrag = true
			cha.position = map.map_to_world(Vector2(4, 1))
			for j in range(cha.lv):
				var id = chaData.getLvIds(cha.id, j + 1)
				if j < 4 and id.find("cex") == - 1:
					chaPool.addItem(id, llp[j])
			emit_signal("onAddBatChara", cha)
			dChas.append(cha)
		else:
			cha.remove()
	var itemNum = lvzb / 3
	for i in range(itemNum):
		var id = itemData.rndPool.rndItem().id
		var item: Item = sys.newItem(id)
		for j in range(100):
			var bl = false
			for k in dChas:
				if k.lv == 2 and k.items.size() < 1 or (k.items.size() < (k.lv - 2)) or j > 50:
					if item.att.maxHp != 0 and (k.attCoe.maxHp > k.attCoe.atk or k.attCoe.maxHp > k.attCoe.mgiAtk):
						k.addItem(item);
						bl = true;
						break;
					elif item.att.atk != 0 and k.attCoe.maxHp < k.attCoe.atk:
						k.addItem(item);
						bl = true;
						break;
					elif item.att.mgiAtk != 0 and k.attCoe.maxHp < k.attCoe.mgiAtk:
						k.addItem(item);
						bl = true;
						break;
					elif k.attCoe.maxHp < k.attCoe.atk:
						k.addItem(item);
						bl = true;
						break;
					elif j > 50 and k.items.size() < 2:
						k.addItem(item);
						bl = true;
						break;
				
			if bl == true: break
				
	lv += 1
	guanKaBtn.setBat()
	emit_signal("onBattleReady")
	
	upChaCell()


var charaNum = [10, 10]
var btChas = []
func battleStart():


	isAiStart = true
	guanKaBtn.setNul()
	btChas.clear()
	charaNum[0] = 0;charaNum[1] = 0
	for x in range(matW):
		for y in range(matH):
			var cha = matCha(Vector2(x, y))
			if cha != null:
				charaNum[cha.team - 1] += 1
				cha.oldCell = cha.cell
				btChas.append(cha)
	emit_signal("onBattleStart")
	audio.playSe("bat")
	dpsMsg.clear()
	
func battleInit():
	var sl = []
	for x in range(matW):
		for y in range(matH):
			
			setMatCha(Vector2(x, y), null, true)
	
	
	for i in map.get_children():
		if i is Chara:
			sl.append(i)
	var delChas = []
	for cha in sl:
		if cha is Chara:
			if cha.team == 1 and batType == 2 and cha.isDeath and cha.isSumm == false:
				cha.revive()
				cha.att.hp = cha.att.maxHp
			cha.delAllBuff()
			if not cha.isDeath and not cha.isSumm:
				cha.cell = cha.oldCell
				cha.setDire(1)
				setMatCha(cha.cell, cha)
			else:
				if cha.team == 1 and cha.isSumm == false:
					delChas.append(cha)
					cha.cell = cha.oldCell
					
				else: cha.remove()
		
	yield(get_tree().create_timer(1), "timeout")
	var chaPs = [2, 5, 10, 15]
	for cha in delChas:
		if cha.lv <= 3 and false:
			var newId = ""
			if cha.lv > 3:
				newId = cha.baseId
			else:
				newId = chaData.getLvIds(cha.id, cha.lv - 1)
			
			var neff = cha.newEff("numHit")
			neff.setNorPos(cha.sprcPos)
			neff.scale = Vector2(1, 1)
			neff.init(0, cha)
			neff.play("tuiHua")
			
			cha.play("del")
			yield(get_tree().create_timer(0.7), "timeout")
			for i in range(2):
				var feiCha = preload("res://ex/eff/feiCha.tscn").instance()
				topUi.add_child(feiCha)
				feiCha.init(cha, Vector2(20 + 120 * i, 670), newId)
			
			cha.remove()
		else:
			var neff = cha.newEff("numHit")
			neff.setNorPos(cha.sprcPos)
			neff.scale = Vector2(1, 1)
			neff.init(0, cha)
			neff.play("tuiHua")
			hitPlayer(cha)
			cha.revive()
			cha.att.hp = cha.att.maxHp
			player.subHp(chaPs[cha.lv - 1])
			
	
	upChaCell()
	if batType == 2: chasPlusHp(2, 2)
	else: chasPlusHp(0.3, 0.6)
	upEvoChara()
	upLv()
	
	if batType == 2:
		batLLv += 1
		emit_signal("onBossEnd", batLLv)
	if batLLv >= guankaMsg.maxLLv:
		sys.newMsg("jieSuan").init(true)
		emit_signal("onTongGuan", jinJieData.nowLv)
	else:
		guanKaBtn.setMap()
		
	emit_signal("onBattleEnd")
		
func hitPlayer(cha):
	var eff = sys.newEff("sk_feiDang", cha.global_position, true)
	var pos = Vector2(1250, 350)
	eff._initFlyPos(pos, 800)
	yield(eff, "onReach")
	sys.newEff("huohua", pos, true)
	var ef = sys.newEff("numHit", pos, true)
	ef.lab.text = str(10)
	ef.playWu()
	audio.playSe("hit2")
	if player.hp <= 0 and not isEnd:
		isEnd = true
		sys.newMsg("jieSuan").init(false)
		
func upChaCell():
	for i in map.get_children():
		if i is Chara:
			if i.team == 1 and i.isSumm == false:
				i.upChaCell()

var isEnd = false
func onCharaDel(cha):



	charaNum[cha.team - 1] = chasNum(cha.team)
	if charaNum[cha.team - 1] <= 0 and not isEnd:
		isAiStart = false
		if cha.team == 1:
			isEnd = true
			yield(get_tree().create_timer(1), "timeout")
			sys.newMsg("jieSuan").init(false)
		else:
			yield(get_tree().create_timer(1), "timeout")
			var msg = sys.newMsg("jiangLiMsg")
			msg.init(batType)
			yield(msg, "popup_hide")
			battleInit()
		
func onCharaCastCdSkill(cha, id):
	pass
	

func chasPlusHp(rep1, rep2):
	for x in range(matW):
		for y in range(matH):
			var cha: Chara = matCha(Vector2(x, y))
			if cha != null:
				if not cha.isDeath:
					cha.plusHp(cha.att.maxHp * rep1)
	for i in btGrid.get_children():
		var cha: Chara = i.get_child(0)
		cha.plusHp(cha.att.maxHp * rep2)
			
func upEvoChara():
	var sl = []
	var bl = false
	for i in btGrid.get_children():
		if i.get_child_count() > 0 and i.get_child(0).lv < 4: sl.append(i.get_child(0))
	
	for cha in map.get_children():
		if cha is Chara:
			if cha != null and cha.lv < 4 and cha.team == 1 and cha.isSumm == false:
				sl.append(cha)
				
	var dic = {}
	for i in sl:
		if dic.has(i.id): dic[i.id].append(i)
		else: dic[i.id] = [];dic[i.id].append(i)
	for i in dic.values():
		if i.size() > 3:
			for j in i:
				j.sureEvo = true
				bl = true
		else: for j in i: j.sureEvo = false
	if bl:
		upLv()
		emit_signal("onSureEvo")


func newChara(id, team = 1):
	var cha = null









	if cha == null:
		cha = preload("res://core/chara.tscn").instance()
		cha.set_script(load("{dir}/{id}/{id}.gd".format({id = id, dir = chaData.infoDs[id].dir})))
	cha.id = id
	cha.team = team
	return cha

func evoChara(cha, id):
	var sl = []
	var items = []
	for i in cha.items:
		items.append(i)
	for i in btGrid.get_children(): sl.append(i.get_child(0))
				
	for cha in map.get_children():
		if cha is Chara:
			if cha != null and cha.lv < 4 and cha.team == 1 and cha.isSumm == false:
				sl.append(cha)
				
	var n = 0
	for i in range(sl.size() - 1, - 1, - 1):
		if sl[i].id == cha.id and sl[i] != cha:
			if sl[i].isItem:
				var bt = sl[i].get_parent()
				setMatCha(sl[i].cell)
				sl[i].remove()
				bt.queue_free()
			else: delMatChara(sl[i])
			sl.remove(i);n += 1
			if n >= 2: break
	var newCha = newChara(id, cha.team)
	var node = cha.get_parent()
	cha.remove()
	newCha.isItem = cha.isItem
	node.add_child(newCha)
	
	if newCha.lv > 3:
		newCha.baseId = cha.id
	newCha.position = cha.position
	newCha.cell = cha.cell
	if not newCha.isItem:
		setMatCha(newCha.cell, newCha)
	for i in items:
		newCha.addItem(i)
	upLv()
	upEvoChara()
	emit_signal("onEvo", newCha)
	upLv()
	return newCha
	
func delMatChara(cha):
	setMatCha(cha.cell)
	cha.remove()

func addBtItem(chal: Chara, team = 1):
	chal.isItem = true
	var bt = preload("res://ui/itemBt/itemBt.tscn").instance()
	var grid = $ui / Panel / ScrollContainer / GridContainer
	grid.add_child(bt)
	bt.init(chal)
	chal.isDrag = true
	chal.team = team
	chal.infoUp()
	return bt
	
func _onAddCha(cha):
	addBtItem(cha)
	upEvoChara()

func _removeCha(cha):
	if cha.team == 1 and cha.isSumm == false:
		upEvoChara()
	
func addItem(item):
	var itemB = preload("res://ui/item/item.tscn").instance()
	itemGrid.add_child(itemB)
	itemB.init(item)
	itemB.isDrag = true
	if sys.isMin == false:
		itemB.rect_min_size *= 0.85
		itemB.get_node("TextureRect").rect_size *= 0.85
		
func _onDelItem(item):
	for i in itemGrid.get_children():
		if i.item == item:
			i.queue_free()
	
func _onChangeGold(val):
	$ui / player / gold.text = "%s：%dG" % [tr("金币"), player.gold]
func upLv(val = 0):
	$ui / player / gold.text = "%s：%dG" % [tr("金币"), player.gold]
	player.renKouVal = chasNum()
	$ui / player / lv.text = "%s：%d | %d/%d" % [tr("等级"), player.lv, player.emp, player.maxEmp]
	$ui / player / renKou.text = "%s：%d/%d" % [tr("人口"), player.renKouVal, player.renKou]
	
func _on_main_tree_entered():
	sys.main = self
	
func setChaPos(cha):
	var d = 2
	cha.position = map.map_to_world(nowCell)
	setMatCha(nowCell, cha)
	nowCell.y += d
	if nowCell.y >= 180 / map.cell_size.y:
		nowCell.x += d
		nowCell.y = 2
		
func matCha(cell):
	if isMatin(cell):
		return mat[cell.x][cell.y]
	else: return null

var sizCells = [Vector2(0, - 1), Vector2(0, 1), Vector2(1, 0), Vector2( - 1, 0)]
func setMatCha(cell, cha = null, force = false):
	cell.x = ceil(cell.x);cell.y = ceil(cell.y)
	if isMatin(cell):
		mat[cell.x][cell.y] = cha
		if cha != null:
			cha.cell = cell
		for i in sizCells:
			if isMatin(i + cell):
				var nCell = i + cell
				var nCellId = cellToId(nCell); var cellId = cellToId(cell)
				var nCha = matCha(i + cell)
				if aStar.are_points_connected(cellId, nCellId): aStar.disconnect_points(cellId, nCellId)
				if cha == null and nCha == null: aStar.connect_points(cellId, nCellId);
				elif cha == null and nCha != null: aStar.connect_points(nCellId, cellId, false);
				elif cha != null and nCha == null: aStar.connect_points(cellId, nCellId, false);
		pass
	
func isMatin(cell):
	if cell.x >= 0 and cell.y >= 0 and cell.x < matW and cell.y < matH: return true
	else: return false
	
func isMatNull(cell):
	if isMatin(cell) and matCha(cell) == null:
		return true
	return false

func _process(delta):
	if Input.is_action_just_pressed("ui_up"):
		for i in $scene / Control.get_children():
			i.queue_free()
		for x in range(matW):
			for y in range(matH):
				var cha = mat[x][y]
				if cha != null:
					var lab = Label.new()
					var pos = map.map_to_world(Vector2(x, y))
					lab.text = "%d,%d" % [x, y]
					lab.margin_left = pos.x
					lab.margin_top = pos.y
					$scene / Control.add_child(lab)





			
func setInfoTxt(s):
	$ui / infoPan / RichTextLabel.bbcode_text = s
	
onready var selImg = $ui / selImg
var selSpr = null
func showSelImg(tx):
	selImg.setT(tx)
	selImg.show()
	$scene / bg / xian.show()
	
var selCha: Chara = null
var selItem = null
var selPos = Vector2()
func _input(event):
	if get_global_mouse_position().x < 1325:
		mml = true
	var pos = map.get_local_mouse_position() + Vector2(map.cell_size.x / 2, map.cell_size.y)
	var cell = map.world_to_map(pos)
	if selCha != null:
		var w = matW
		if not sys.test: w = matW / 2
		if cell.x < 0: cell.x = 0;
		if cell.y < 0: cell.y = 0;
		if (pos.y < 630):
			selPos = map.map_to_world(cell) + $scene.position
			selImg.upSpr(selPos)
		else:
			selImg.position.y = - 1000;selImg.position.x = - 1000
		if event is InputEventMouseButton and event.pressed == false and selCha != null:
			if cell.x >= 0 and cell.x < w and cell.y >= 0 and cell.y < matH:
				if selCha.isItem:
					var num = chasNum()
					if num < player.renKou or matCha(cell) != null:
						var muCha = matCha(cell)
						setMatCha(cell)
						var bta = selCha.get_parent()
						bta.remove_child(selCha)
						bta.queue_free()
						var cha = selCha
						map.add_child(cha)
						cha.cell = cell
						cha.position = pos
						cha.isDrag = true
						cha.isItem = false
						setMatCha(cell, cha)
						cha.infoUp()
						if cell.x >= matW / 2: cha.team = 2; else: cha.team = 1
						if muCha != null:
							muCha.get_parent().remove_child(muCha)
							var bt = addBtItem(muCha)
							bt.get_parent().move_child(bt, selCha.get_parent().get_index())
						emit_signal("onPlaceChara", cha)
					else: sys.newBaseMsg("提示", "人口不足")
					
						
				else:
					var muCha = matCha(cell)
					var muCell = selCha.cell
					setMatCha(selCha.cell)
					setMatCha(cell)
					setMatCha(selCha.cell, muCha)
					setMatCha(cell, selCha)
					if cell.x >= matW / 2: selCha.team = 2; else: selCha.team = 1
			else:
				pos = get_global_mouse_position()
				var grid = $ui / Panel / ScrollContainer / GridContainer
				if pos.y > 600:
					pos = grid.get_local_mouse_position()
					var inx = int(pos.x / (144))
					inx = clamp(inx, 0, grid.get_child_count())
					if selCha.isItem:
						var node = selCha.get_parent()
						node.get_parent().move_child(node, inx)
					else:
						selCha.get_parent().remove_child(selCha)
						var bt = addBtItem(selCha)
						bt.get_parent().move_child(bt, inx)
						setMatCha(selCha.cell)
					
				elif cell == Vector2(5, 2):
					emit_signal("onItemIn", selCha)
			audio.playSe("luo")
			selCha = null
			selImg.hide()
			$scene / bg / xian.hide()
			upLv()
	if selItem != null and event is InputEventMouseButton and event.pressed == false:
		var cha = matCha(cell)
		if cha != null and cha.team == 1:
			selItem.setCha(cha)
			emit_signal("onPlaceItem", selItem.item)
		elif cell == Vector2(5, 2):
			emit_signal("onItemIn", selItem)
		else:
			pos = get_global_mouse_position()
			var grid = $ui / Panel / ScrollContainer / GridContainer
			if pos.y > 650 and grid.get_child_count() > 0:
				pos = grid.get_local_mouse_position()
				var inx = int(pos.x / (144))
				inx = clamp(inx, 0, grid.get_child_count() - 1)
				selItem.setCha(grid.get_child(inx).get_child(0))
				emit_signal("onPlaceItem", selItem.item)
		selItem = null
		audio.playSe("luo")
		
func itemSetCha(itemBt, cha):
	itemBt.setCha(cha)
	emit_signal("onPlaceItem", itemBt.item)
		
func chasNum(team = 1):
	var n = 0
	for i in map.get_children():
		if i is Chara and i != null and not i.isDeath and i.team == team: n += 1
	return n

func _on_guanKa_pressed():
	if isEnd: return
	if guanKaBtn.step == 1:
		guankaMsg.popup()
	elif guanKaBtn.step == 2:
		if chasNum() <= 0:
			sys.newBaseMsg("提示", "你还没有作战单位，请将下方单位拖至场上。")
		else: battleStart()

func _on_optionBtn_pressed():
	sys.newMsg("option").popup()
	
func exit():
	if isEnd == false: saveInfo()
	var main = load("res://control.tscn").instance()
	delCharaRs()
	queue_free()
	get_parent().add_child(main)

func delCharaRs():
	for i in charaRs: i.queue_free()

func _on_main_tree_exiting():
	sys.main = null

func _on_optionBtn2_pressed():
	sys.newMsg("testMsg").init()
	pass







func showMao():
	$scene / bg / mao.show()

var spd = 100.0
func _on_CheckButton_pressed():
	if $ui / suDu / CheckButton.pressed:
		Engine.time_scale = 2.0
	else: Engine.time_scale = 1.0

func loadInfo():
	var file = File.new()
	if file.open("user://data1/main.save", File.READ) == OK:
		var dic = parse_json(file.get_line())
		file.close()
		if dic == null: print_debug("读取存档错误")
		
		guankaMsg.infoSet(dic["guankaDic"])
		player.infoSet(dic["playDic"])
		
	var dir = Directory.new()
	dir.remove("user://data1/main.save")
	chaData.rndPoolRs()
	$ui / jiaoChen.queue_free()
	playerPan.upHp(0)
	
func saveInfo():
	var file = File.new()
	var dir = Directory.new()
	
	dir.make_dir_recursive("user://data1/")
	var dic = {
		guankaDic = guankaMsg.infoGet(), 
		playDic = player.infoGet(), 
	}
	file.open("user://data1/main.save", File.WRITE)
	file.store_line(to_json(dic))
	file.close()

func _on_dpsBtn_pressed():
	dpsMsg.popup()

var mml = true
func _on_ReferenceRect_mouse_entered():




	pass
var isNumVis = true
func _on_numBtn_pressed():
	isNumVis = $ui / suDu / numBtn.pressed
	
func rcha(cha):
	charaRs.append(cha)
	if charaRs.size() > 100000:
		if is_instance_valid(charaRs[0]):
			charaRs[0].queue_free()
		charaRs.remove(0)
