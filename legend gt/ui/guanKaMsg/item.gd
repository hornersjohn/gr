extends TextureButton
signal onPressed(item)
var lv = 1
var type = 1
var lvcs = []
var lvzb = 0
var batType = 0

func _ready():
	disabled = true

func _on_TextureButton_pressed():
	emit_signal("onPressed", self)

func initBat(lv, batType = 0):
	self.batType = batType
	if batType == 1:
		lv = int(lv * 1.3)
	elif batType == 2:
		lv = int(lv * 1.7)
	self.lv = int(lv)
	type = 1
	var lvmm = [0.6, 0.65, 0.7, 0.8, 0.9, 1.05, 1.2]
	
	
	var lvpow = int(lv * lvmm[jinJieData.nowLv] * 1.15)
	if lvpow > 27:
		var lvp = lvpow
		lvpow = int(lvpow * 0.7)
		lvzb = int(lvp * 0.3)
	lvpow = clamp(lvpow, 1, 9999)
	
	for i in range(5):
		if lvpow >= 126:
			lvpow -= 27
			lvcs.append(chaData.infosLv4[sys.rndRan(0, chaData.infosLv4.size() - 1)].id)
		else:
			break
	
	var pn = 0
	while pn != lvpow:
		sys.main.rndLv = lvpow - pn
		var info = sys.main.rndInfo()
		var s = info.id
		if s == "": print_debug("随到单位id出错")
		var n = 9 / chaData.rndPool.getItemW(info)
		if pn + n <= lvpow:
			pn += n
			lvcs.append(s)
			if lvcs.size() >= 20: break
	
	sprInit()
	
func loadBat(lv, batType, lvcs, lvzb):
	self.lvcs = lvcs
	self.lvzb = lvzb
	self.lv = lv
	self.batType = batType
	type = 1
	sprInit()
	
func sprInit():
	for i in range(lvcs.size()):
		var spr = Sprite.new()
		spr.centered = false
		var id = lvcs[i]
		if chaData.infoDs[id].dir.left(8) != "res://ex":
			var im = Image.new()
			im.load("%s/%s/cha.png" % [chaData.infoDs[id].dir, id])
			
			var imt = ImageTexture.new()
			imt.create_from_image(im)
			imt.flags = 4
			spr.texture = imt
			
		else: spr.texture = load("res://ex/chara/%s/cha.png" % id)
		spr.position = Vector2(i * 60 - spr.texture.get_width() / 2 + 80, - spr.texture.get_height() + 115)
		add_child(spr)
		if i > 2: break
	
	if batType == 1: $Label.text = "%s（lv：%d）" % [tr("精英战斗"), lv]
	elif batType == 0: $Label.text = "%s（lv：%d）" % [tr("战斗"), lv]
	elif batType == 2: $Label.text = "%s（lv：%d）" % [tr("BOSS"), lv]

func initShop(lv):
	type = 2
	setIco("anvil_icon")
	$Label.text = "商店"
	
func initXiuXi():
	type = 3
	setIco("cerbalism_icon")
	$Label.text = "休息"
	
func initBaoWu(btype = 1):
	batType = btype
	type = 4
	setIco("chest_icon")
	if batType == 1:
		$Label.text = "小宝藏"
	elif batType == 2: $Label.text = "大宝藏"
	
func initDuBo():
	type = 5
	setIco("bag_icon")
	$Label.text = "赌一把"

func setIco(name):
	var spr = Sprite.new()
	spr.centered = true
	spr.texture = load("res://ui/guanKaMsg/%s.png" % name)
	spr.position = Vector2(texture_normal.get_width() * 0.5, texture_normal.get_height() * 0.5)
	add_child(spr)
