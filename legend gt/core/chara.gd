extends Obj

class_name Chara

signal onAtkInfo(atkInfo)
signal onHurt(atkInfo)
signal onHurtEnd(atkInfo)
signal onPlusHp(val)
signal onKillChara(atkInfo)
signal onDeathCom(atkInfo)
signal onDeath(atkInfo)
signal onAtkChara(atkInfo)
signal onChangeTeam(team)
signal onPressed(cha)
signal onAddItem(item)
signal onDelItem(item)
signal onCastCdSkill(id)
signal onAddBuff(buff)
signal onCharaDel(cha)
signal onNewChara(cha)

var moveSpeed = 300
export  var team = 1 setget set_team, get_team
var aiCha: Chara = null

var oldCell = Vector2()
var aiOn = true
var att: Att = Att.new()
var attInfo: Att = Att.new()
var attCoe: Att = Att.new()
var attAdd: Att = Att.new()
var atts = []
var buffs = []
var items = []
var isMoveIng = false
export  var isItem = false
var isDeath = false
var isDrag = false
var isSumm = false
var sureEvo = false setget set_sureEvo
var sprcPos = Vector2()
var direc = ""

var id = ""
var chaName = ""
var evos = []
var skillStrs = []
var atkEff = "atk_gongJian"
var lv = 1

onready var aiTimer = $ex / aiTimer
onready var img = $spr / normal / Node2D / Sprite
var timer = Timer.new()

var skills = []
class Skill:
	var id = ""
	var nowTime = 0
	var cd = 0
	
func _init():
	className = "Chara"
	masCha = self
	
func _ready():
	add_child(timer)
	set_team(team)
	var leng = 2.0
	anim.get_animation("atk").length = leng
	anim.get_animation("atkUp").length = leng
	anim.get_animation("atkDown").length = leng
	add_to_group("Chara")
	att.maxHp = 30
	att.hp = att.maxHp
	att.atk = 5
	attInfo.maxHp = 10
	addAtt(attInfo)
	addAtt(attAdd)
	direc = chaData.infoDs[self.id].dir + "/"
	infoUp()
	if sys.main != null:
		sys.main.connect("onBattleStart", self, "_runBattleStart")
		sys.main.connect("onBattleEnd", self, "_runBattleEnd")
		sys.main.connect("onCharaDel", self, "_runCharaDel")
		sys.main.connect("onCharaCastCdSkill", self, "_runCharaCastCdSkill")
		sys.main.connect("onCharaNewChara", self, "_runCharaNewChara")
	_connect()
	img.connect("onPressed", self, "_on_Sprite_pressed")
	
func _info(): pass
func _extInit(): pass
func _connect(): pass
func _runBattleStart(): if not isItem: _onBattleStart()
func _runBattleEnd(): if not isItem: _onBattleEnd()
func _runCharaDel(cha):
	if not isItem:
		_onCharaDel(cha)
		emit_signal("onCharaDel", cha)
func _runCharaCastCdSkill(cha, id): if not isItem: _onCharaCastCdSkill(cha, id)
func _runCharaNewChara(cha): if not isItem: _onCharaNewChara(cha)
	
func delConnect():
	for i in get_incoming_connections():
		i["source"].disconnect(i["signal_name"], self, i["method_name"])
	
func infoUp():
	evos.clear()
	skillStrs.clear()
	skills.clear()
	attAdd.clear()
	_info()
	_extInit()
	if isItem == false:
		pass
		
	if id != "":
		if chaData.infoDs[id].dir.left(8) != "res://ex":
			var im = Image.new()
			im.load("%s/%s/cha.png" % [chaData.infoDs[id].dir, id])
			var imt = ImageTexture.new()
			imt.create_from_image(im)
			imt.flags = 4
			img.texture = imt
			
		else: img.texture = load("res://ex/chara/%s/cha.png" % id)
		
		img.margin_top = - img.texture.get_height() + 35
		img.margin_left = - img.texture.get_width() / 2
		$ui / chaName.text = chaName
		$ui / chaName.modulate = Color(config.itemGradeColors[lv - 1])
		sprcPos = Vector2(0, - img.texture.get_height() / 2)
		
		if not isItem:
			$ui / chaName.hide()
			
		else:
			
			$ui / chaName.show()
	var lvL = 1 + (lv - 1) * 1
	img.rect_pivot_offset = Vector2(img.texture.get_width() * 0.5, img.texture.get_height())
	attInfo.atkRan = attCoe.atkRan
	attInfo.maxHp = attCoe.maxHp * 112.5 * lvL
	attInfo.atk = attCoe.atk * 8.57 * lvL
	attInfo.mgiAtk = attCoe.mgiAtk * 13.79 * lvL
	attInfo.def = attCoe.def * 15 * lvL
	attInfo.mgiDef = attCoe.mgiDef * 16.66 * lvL
	attInfo.cri = 0.2
	upAtt()
func evoUp(id):
	self.id = id
	infoUp()

func set_team(val):
	team = val
	emit_signal("onChangeTeam", team)
func get_team():
	return team

func addSkillTxt(s):
	skillStrs.append(s)
	
func _animEnd():
	play("idle", 0)
	
func _play():
	if nowAnim == "idle": move()
	
func _move_side(delta):
	if not isItem:
		var spd = moveSpeed
		if sys.main.isAiStart == false: spd = 1000
		var s = (sys.main.map.map_to_world(cell) - position).normalized() * delta * spd
		if s.length() < (sys.main.map.map_to_world(cell) - position).length():
			position += s
			isMoveIng = true
		else:
			isMoveIng = false
			position = sys.main.map.map_to_world(cell)

func moveCell(v):
	setCell(cell + v)

func setCell(cell):
	if sys.main.isMatin(cell):
		if sys.main.matCha(cell) == null:
			var oldv = self.cell
			sys.main.setMatCha(cell, self)
			if oldv != cell:
				sys.main.setMatCha(oldv)
			return true
	return false

func matCha(cell): return sys.main.matCha(cell)

func isMatin(cell): return sys.mian.isMatin(cell)

func getCellChas(cell, ran = 1, mTeam = 1):
	var chas = []
	for x in range(cell.x - ran, cell.x + ran + 1):
		for y in range(cell.y - ran, cell.y + ran + 1):
			var cha = matCha(Vector2(x, y))
			if cha != null and cellRan(cha.cell, cell) <= ran:
				if mTeam == 0 or (mTeam == 1 and cha.team != team) or (mTeam == 2 and cha.team == team):
					chas.append(cha)
	return chas

func getAllChas(mTeam = 1):
	var chas = []
	for x in range(0, sys.main.matW):
		for y in range(0, sys.main.matH):
			var cha = matCha(Vector2(x, y))
			if cha != null:
				if mTeam == 0 or (mTeam == 1 and cha.team != team) or (mTeam == 2 and cha.team == team):
					chas.append(cha)
	return chas

func rndChas(chas, num = 1):
	if chas != null and chas.size() > 0:
		return chas[sys.rndRan(0, chas.size() - 1)]
	else: return null

func setAiCha(cha):
	aiCha = cha
	$ui / Label.text = "%s|%s" % [name, aiCha.name]
	
func set_sureEvo(val):
	sureEvo = val
	$spr / normal / Node2D / Sprite.use_parent_material = not val

func _hit(atkInfo: AtkInfo):
	pause(0.15, false)
	atkInfo.isCri = false
	atkInfo.isMiss = false
	
	hitHua = true
	hurtArit(atkInfo)
	
func newHitHua():
	var node = sys.newEff("huohua", position + sprcPos)
	node.rotation = randi() % 22 + 22
	node.z_index = 50
	audio.playSe("hit1_2")
	

func hurtChara(cha, val, hurtType = HurtType.PHY, atkType = AtkType.SKILL):
	var af = AtkInfo.new()
	af.atkVal = val
	af.atkType = atkType
	af.hurtType = hurtType
	af.atkCha = self
	af.hitCha = cha
	cha._hit(af)
var lastNum = null

var isHp0 = false
var hurtNum = 0
var hitHua = false

func hurtArit(atkInfo: AtkInfo):
	if isDeath or isItem:
		return
	if hurtNum > 5: return
	emit_signal("onAtkInfo", atkInfo)
	_onAtkInfo(atkInfo)
	hurtNum += 1
	if not atkInfo.atkCha.isItem:
		atkInfo.atkCha.emit_signal("onAtkInfo", atkInfo)
		atkInfo.atkCha._onAtkInfo(atkInfo)
		
	if atkInfo.hurtType == HurtType.PHY:
		var defVal = clamp(att.def - att.def * atkInfo.atkCha.att.penL - atkInfo.atkCha.att.pen, 0, 10000)
		atkInfo.hurtVal = atkInfo.atkVal * (100 / (100 + defVal))
	elif atkInfo.hurtType == HurtType.MGI:
		var defVal = clamp(att.mgiDef - att.mgiDef * atkInfo.atkCha.att.mgiPenL - atkInfo.atkCha.att.mgiPen, 0, 10000)
		atkInfo.hurtVal = atkInfo.atkVal * (100 / (100 + defVal))
	else:
		atkInfo.hurtVal = atkInfo.atkVal
	if atkInfo.canCri and randf() < atkInfo.atkCha.att.cri:
		atkInfo.hurtVal *= 2 * (1 + atkInfo.atkCha.att.criR)
		atkInfo.isCri = true
	if atkInfo.atkType == AtkType.NORMAL and randf() < att.dod:
		atkInfo.isMiss = true
	
	atkInfo.hurtVal *= 1 + atkInfo.atkCha.att.atkR - clamp(att.defR, - 1.0, 0.7)
		
	if not isItem:
		atkInfo.atkCha.emit_signal("onAtkChara", atkInfo)
		atkInfo.atkCha._onAtkChara(atkInfo)
	if not isItem:
		emit_signal("onHurt", atkInfo)
		_onHurt(atkInfo)
	if not atkInfo.isMiss:
		att.hp -= atkInfo.hurtVal
		sys.main.emit_signal("onCharaHurt", atkInfo)
	if not isItem:
		emit_signal("onHurtEnd", atkInfo)
		
	atkInfo.canCri = false
	
	if atkInfo.atkType == AtkType.NORMAL and atkInfo.atkCha.isSumm and atkInfo.atkCha.att.atkRan == 1:
		self.aiCha = atkInfo.atkCha
	
	if atkInfo.atkCha.att.suck > 0 and atkInfo.hurtType == HurtType.PHY:
		atkInfo.atkCha.plusHp(atkInfo.hurtVal * atkInfo.atkCha.att.suck)
	elif atkInfo.atkCha.att.mgiSuck > 0 and atkInfo.hurtType == HurtType.MGI:
		atkInfo.atkCha.plusHp(atkInfo.hurtVal * atkInfo.atkCha.att.mgiSuck)
	
	if sys.main.isNumVis:
		var node = sys.newEff("numHit", position + sprcPos, false, 1)
		node.z_index = 51;
		node.init(atkInfo.hurtVal, self)
		if atkInfo.isMiss: node.play("miss")
		elif atkInfo.hurtType == HurtType.PHY: node.play("wu")
		elif atkInfo.hurtType == HurtType.MGI: node.play("mo")
		elif atkInfo.hurtType == HurtType.REAL: node.play("zhen")
		if atkInfo.isCri:
			node.lab.text += "!"

	if att.hp <= 0.0 and isDeath == false:
		att.hp = 0
		isDeath = true
		if not isItem:
			
			emit_signal("onDeath", atkInfo)
			_onDeath(atkInfo)
			atkInfo.atkCha.emit_signal("onKillChara", atkInfo)
			atkInfo.atkCha._onKillChara(atkInfo)
			sys.main.emit_signal("onCharaDel", self)
		sys.delEff(position, dire)
		del()

func plusHp(val, veff = true):
	if isDeath: return
	val = val * (1 + att.reHp)
	att.hp += val
	if att.hp > att.maxHp: att.hp = att.maxHp
	emit_signal("onPlusHp", val)
	if veff:
		var eff = newEffIn("plusHp")
		eff.setNorPos(sprcPos);eff.setAmount(int(val / att.maxHp * 40))
		if sys.main.isNumVis:
			var node = null
			if isItem: node = newEffIn("numHit")
			else: node = newEff("numHit")
			node.setNorPos(sprcPos)
			
			node.scale = Vector2(1, 1)
			node.init(val, self)
			node.play("hp")

func upAtt(all = true):
	var hpL = att.hp / att.maxHp
	
	att.clear()
	att.spd = 1.0
	for i in atts:
		att.plus(i)









		







	for i in config.attRdsKeys:
		att.info[config.attRds[i]] *= 1 + att.info[i]
	
	att.hp = att.maxHp * hpL
	isUpAtt = false
	
var upAtts = []
var isUpAtt = false
func changeAtt(id):
	isUpAtt = true



func addAtt(att):
	if att != null:
		atts.append(att)
		att.connect("onChange", self, "changeAtt")
		upAtt()



func delAtt(att):
	if att != null:
		atts.erase(att)
		if att.is_connected("onChange", self, "changeAtt"): att.disconnect("onChange", self, "changeAtt")
		upAtt()

func addBuff(buff):
	if buff != null:
		buff.masCha = self
		var b = hasBuff(buff.id)
		if b != null and not (b is Item) and b.life != null:
			if buff.life == null: return buff
			b.life += buff.life
			if b.life > 20: b.life = 20
			emit_signal("onAddBuff", buff)
			sys.main.emit_signal("onCharaAddBuff", buff)
			_onCharaAddBuff(buff)
			if isItem == false: _onAddBuff(buff)
			return b
		else:
			buff.setCha(self)
			buffs.append(buff)
			if buff.att != null:
				addAtt(buff.att)
			emit_signal("onAddBuff", buff)
			sys.main.emit_signal("onCharaAddBuff", buff)
			_onCharaAddBuff(buff)
			if isItem == false: _onAddBuff(buff)
			return buff
		

func hasBuff(id):
	for i in buffs:
		if i.id == id:
			return i
	return null

func delBuff(buff):
	if buff != null:
		buffs.erase(buff)
		if buff.att != null:
			delAtt(buff.att)
		buff.del()

func delAllBuff():
	for i in range(buffs.size() - 1, - 1, - 1):
		if buffs.size() == 0: break
		var b = buffs[i]
		if not (b is Item):
			delBuff(b)
			
	for i in skills:
		i.nowTime = 0

func addItem(item):
	if item != null and item.type == config.EQUITYPE_EQUI and items.size() < 3:
		addBuff(item)
		items.append(item)
		emit_signal("onAddItem", item)
		return true
	return false
func delItem(item):
	if item != null:
		delBuff(item)
		items.erase(item)
		item.masCha = null
		emit_signal("onDelItem", item)

func hasItem(id):
	for i in items:
		if i.id == id:
			return i
	return null

func addCdSkill(id, cd):
	var sk = Skill.new()
	sk.cd = cd;sk.id = id
	skills.append(sk)

func _castCdSkill(id): pass

func getSkill(id):
	for i in skills:
		if i.id == id: return i
var time = 0.0
func _process(delta):
	if isItem or isDeath or sys.main.isAiStart == false: return
	if isUpAtt: upAtt(false)
	if aiOn: _ai(delta)
	for i in range(buffs.size() - 1, - 1, - 1):
		if buffs.size() == 0: break
		if buffs.size() <= i: break
		var b = buffs[i]
		b.process(delta)
		if b.isDel:
			delBuff(b)
	for i in skills:
		i.nowTime += delta * (1 + att.cd)
		if i.nowTime >= i.cd:
			i.nowTime = 0
			_castCdSkill(i.id)
			emit_signal("onCastCdSkill", i.id)
			sys.main.emit_signal("onCharaCastCdSkill", self, i.id)
			_onCharaCastCdSkill(self, i.id)
			newEff("xuLi2").setNorPos(sprcPos)
			
	time += delta
	if time >= 1:
		time -= 1
		_upS()
		upChaCell()
		
	hurtNum = 0
	
	if hitHua:
		hitHua = false
		newHitHua()
			
func upChaCell():
	if isItem == false and isDeath == false and sys.main.matCha(cell) != self:
			sys.main.setMatCha(cell, null)
			sys.main.setMatCha(cell, self)
			

func death():
	isDeath = true
	set_process(false)
	set_physics_process(false)

func del():
	if isDeath:
		delAllBuff()
		death()
		anim.play("del", 100)
		_del()
		sys.main.onCharaDel(self)
	
func _del():
	sys.main.setMatCha(cell, null)
	pass
func remove():
	delConnect()
	death()
	for i in range(items.size() - 1, - 1, - 1):
		delItem(items[i])
	for i in range(buffs.size() - 1, - 1, - 1):
		delBuff(buffs[i])
	get_parent().remove_child(self)
	sys.main._removeCha(self)
	sys.main.rcha(self)

func revive(hp = 999999):
	isDeath = false
	set_sureEvo(false)
	
	set_process(true)
	aiCha = null
	set_physics_process(true)
	anim.play("evo")
	show()
	
func aiSeekCha(exCha = null):
	var minl = 1000
	for x in range(sys.main.matW):
		for y in range(sys.main.matH):
			var i = sys.main.mat[x][y]
			if i != null and i != exCha and i != self and i.team != team and not i.isDeath and not i.isItem and i.att.hp > 0:
				var l = cellRan(i.cell)
				if l < minl:
					setAiCha(i)
					minl = l

func cellRan(v, cell = null):
	if cell == null: cell = self.cell
	var x = abs(cell.x - v.x)
	var y = abs(cell.y - v.y)
	return x + y
	
func act( var name,  var inX = 0,  var inY = 0):
	if isDeath: return
	if name == "move" and actLv == 0 and not isMoveIng:
		setDire(inX)
		play("move")
		setCell(Vector2(inX, inY))
		
		
	elif name == "idle" and nowAnim == "move" and actLv == 0:
		if nowAnim == "idle":
			move()
		else:
			play(name)
	elif name == "atk" and actLv < 10:
		setDire(inX)
		if inY > 0: play("atkDown", 11, 0, att.spd)
		if inY < 0: play("atkUp", 11, 0, att.spd)
		else: play("atk", 11, 0, att.spd)
		
var atime = 0
func _ai(delta):
	if not sys.isClass(aiCha, "Chara") or aiCha.isDeath or aiCha.att.hp <= 0:
		aiSeekCha()
		return
	var vpos = Vector2(aiCha.cell.x - cell.x, aiCha.cell.y - cell.y)
	var l = cellRan(aiCha.cell)
	if l > 1000: return
	atime -= delta
	if l <= att.atkRan:
		act("atk", vpos.x, vpos.y)
	elif not isMoveIng and atime <= 0:
		sys.main.setMatCha(aiCha.cell, null)
		var ps = sys.main.aStar.get_point_path(sys.main.cellToId(cell), sys.main.cellToId(aiCha.cell))
		sys.main.setMatCha(aiCha.cell, aiCha)
		if ps.size() > 1:
			act("move", ps[1].x, ps[1].y)
		else:
			if vpos.x > 0: vpos.x = 1;elif vpos.x < 0: vpos.x = - 1
			if vpos.y > 0: vpos.y = 1;elif vpos.y < 0: vpos.y = - 1
			if vpos.x != 0: vpos.y = 0
			vpos += cell
			if matCha(vpos) == null:
				act("move", vpos.x, vpos.y)
			else:
				aiSeekCha(aiCha)
				if atime <= 0: atime = 0.1

func dang():
	normalAtkChara(aiCha)
	
func reTimer(time):
	timer.start(time)
	return timer

func normalAtkChara(cha):
	var d: Eff = newEff(atkEff, sprcPos)
	d._initFlyCha(cha, 300)
	_onNormalAtk(cha)
	yield(d, "onReach")
	if sys.isClass(cha, "Chara"):
		atkInfo.atkCha = self
		atkInfo.rate = 1
		atkInfo.isCri = false
		atkInfo.canCri = true
		atkInfo.atkVal = att.atk
		atkInfo.hurtType = HurtType.PHY
		atkInfo.atkType = AtkType.NORMAL
		atkRun(cha)

func _on_Sprite_pressed():
	var s = getInfo()
	
	
	var msg = sys.newMsg("charaInfoMsg")
	msg.init(self, s)
	emit_signal("onPressed", self)

func getInfo():
	var s = \
\
\
\
\
	"{hpT}：{hp}/{maxHp}\n{atkRanT}：{atkRan}  {criT}：{cri}\n{atkT}：{atk}  {mgiAtkT}：{mgiAtk}\n{defT}：{def}  {mgiDefT}：{mgiDef}\n\n"
	var dic = {
		hp = int(att.hp), 
		maxHp = int(att.maxHp), 
		atkRan = int(att.atkRan), 
		cri = "%d%%" % [att.cri * 100], 
		atk = int(att.atk), 
		def = int(att.def), 
		mgiAtk = int(att.mgiAtk), 
		mgiDef = int(att.mgiDef), 
		hpT = tr("生命值"), 
		atkRanT = tr("攻击范围"), 
		criT = tr("暴击率"), 
		atkT = tr("物理攻击"), 
		mgiAtkT = tr("魔法强度"), 
		defT = tr("物理防御"), 
		mgiDefT = tr("魔法防御"), 
	}
	var cs = ["#4080c6", "#7a70fe", "#ba7aff", "#ba7aff", "#ba7aff"]
	s = s.format(dic)
	var sks = ""
	for i in range(skillStrs.size()):
		if i > 4:
			sks += "[color=%s]%s[/color]\n" % [cs[4], tr(skillStrs[i])]
		else: sks += "[color=%s]%s[/color]\n" % [cs[i], tr(skillStrs[i])]
	var nameStr = "[color=%s]%s[/color]" % [config.itemGradeColors[lv - 1], tr(chaName)]
	s = "%s\n[color=#71b569]%s[/color]%s" % [nameStr, s, sks]
	
	return s

func newChara(id, cell):
	var vs = [Vector2(0, 0), Vector2(1, 0), Vector2( - 1, 0), Vector2(0, 1), Vector2(0, - 1), Vector2(1, 1), Vector2( - 1, 1), Vector2( - 1, - 1), Vector2(1, - 1)]
	var cl = null
	for i in vs:
		var lc = i + cell
		if matCha(lc) == null:
			cl = lc
			break
	
	if cl != null and sys.main.isMatin(cl) and matCha(cl) == null:
		var cha = sys.main.newChara(id, team)
		sys.main.map.add_child(cha)
		sys.main.setMatCha(cl, cha)
		cha.position = sys.main.map.map_to_world(cl)
		cha.isSumm = true
		cha.newEff("sk_zhao")
		emit_signal("onNewChara", cha)
		sys.main.emit_signal("onCharaNewChara", cha)
		return cha

func _onAtkInfo(atkInfo): pass
func _onHurt(atkInfo): pass
func _onKillChara(atkInfo): pass
func _onDeath(atkInfo): pass
func _onAtkChara(atkInfo): pass
func _onAddBuff(buff): pass
func _onNormalAtk(cha): pass
func _onBattleStart(): pass
func _onBattleEnd(): pass
func _onCharaDel(cha): pass
func _onCharaCastCdSkill(cha, id): pass
func _onCharaNewChara(cha): pass
func _onCharaAddBuff(buff): pass
func _upS(): pass


