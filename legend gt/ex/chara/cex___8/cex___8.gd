extends Chara

func _info():
	pass

func _extInit():
	._extInit()
	chaName = "古龙斯拉夫-传奇"
	lv = 4
	attCoe.atkRan = 3
	attCoe.maxHp = 7
	attCoe.atk = 6
	attCoe.mgiAtk = 6
	attCoe.def = 4
	attCoe.mgiDef = 7
	atkEff = "atk_dao"

	addSkillTxt("普攻额外攻击2名最近的敌人，造成50%魔法伤害（视为普通攻击），附加1层[烧灼]")
	addCdSkill("c8_1_2", 7)
	addSkillTxt("每7秒：对敌方攻击和法强最高的单位造成200%的魔法伤害，并附加10层结霜")
	addSkillTxt("免疫所有异常状态！")
	addSkillTxt("闪现至后排，普攻附带目标和自身30%法强的魔法伤害。")

var baseId = ""


func _connect():
	._connect()

var p = 0.5
					
func _onNormalAtk(cha):
	._onNormalAtk(cha)
	if atkInfo.atkType == AtkType.NORMAL:
		hurtChara(cha, att.mgiAtk * p, Chara.HurtType.MGI, Chara.AtkType.EFF)
		cha.addBuff(b_shaoZhuo.new(1))
		var chas = getCellChas(cell, att.atkRan)
		
		chas.sort_custom(self, "sort")
		var n = 0
		for i in chas:
			if i != cha:
				n += 1
				fx(i)
				if n == 2:
					break
					
func sort(a, b):
	if cellRan(a.cell, cell) < cellRan(b.cell, cell):
		return true
	return false
	
func fx(cha):
	var d: Eff = newEff("atk_dang", sprcPos)
	d._initFlyCha(cha)
	yield(d, "onReach")
	if sys.isClass(cha, "Chara"):
		hurtChara(cha, att.mgiAtk * p, Chara.HurtType.MGI, Chara.AtkType.NORMAL)
		cha.addBuff(b_shaoZhuo.new(1))
		
func _onBattleStart():
	._onBattleStart()
	var sk = getSkill("c8_1_2")
	sk.nowTime = sk.cd
	
	yield(reTimer(0.4), "timeout")
	var mv = Vector2(cell.x, cell.y)
	if team == 1: mv.x = 7
	else: mv.x = 0
	var vs = [Vector2(0, 0), Vector2(1, 0), Vector2( - 1, 0), Vector2(0, 1), Vector2(0, - 1), Vector2(1, 1), Vector2( - 1, 1), Vector2( - 1, - 1), Vector2(1, - 1)]
	for i in vs:
		var v = mv + i
		if matCha(v) == null and sys.main.isMatin(v):
			if setCell(v):
				var pos = sys.main.map.map_to_world(cell)
				ying(pos)
				position = pos
				aiCha = null
				break
				
func ying(pos):
	var l: Vector2 = pos - position
	var s = 25
	var rs = preload("res://core/ying.tscn")
	var n = l.length() / s
	for i in range(n):
		var spr = rs.instance()
		sys.main.map.add_child(spr)
		spr.texture = img.texture_normal
		spr.position = position + s * (i + 1) * l.normalized() - Vector2(img.texture_normal.get_width() / 2, img.texture_normal.get_height())
		spr.init(255 / n * i + 100)
		
func _onAtkChara(atkInfo: AtkInfo):
	._onAtkChara(atkInfo)
	if atkInfo.atkType == AtkType.NORMAL: hurtChara(atkInfo.hitCha, att.mgiAtk * 0.3 + atkInfo.hitCha.att.mgiAtk * 0.3, Chara.HurtType.MGI, Chara.AtkType.EFF)


func _castCdSkill(id):
	._castCdSkill(id)
	if id == "c8_1_2":
		var chas = getAllChas()
		if chas.size() == 0: return
		var ac = chas[0]
		var bc = chas[0]
		for i in chas:
			if ac.att.atk < i.att.atk: ac = i
			if ac.att.mgiAtk < i.att.mgiAtk: bc = i
		fx2(ac)
		if ac != bc: fx(bc)
		
func fx2(cha):
	var d: Eff = newEff("sk_feiDang", sprcPos)
	d._initFlyCha(cha)
	yield(d, "onReach")
	if sys.isClass(cha, "Chara"):
		hurtChara(cha, att.mgiAtk * 1.7, Chara.HurtType.MGI)
		cha.addBuff(b_jieShuang.new(10))
		pass

func _onAddBuff(buff: Buff):
	if buff.isNegetive:
		buff.isDel = true

