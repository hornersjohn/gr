extends "res://ex/chara/c5/c5.gd"

func _info():
	pass

func _extInit():
	._extInit()
	chaName = "潜行者"
	lv = 2
	attCoe.atk += 1
	attCoe.maxHp += 1
	attCoe.atkRan += 1
	addSkillTxt("开始战斗时：闪现至敌方后排，下次普通攻击造成双倍伤害(可暴击)，并赋予5层[流血],每5秒重置.")
	

func _connect():
	._connect()
	
func _castCdSkill(id):
	._castCdSkill(id)

var bl = false

func _onBattleStart():
	yield(reTimer(0.4), "timeout")
	bl = true
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
		spr.texture = img.texture
		spr.position = position + s * (i + 1) * l.normalized() - Vector2(img.texture.get_width() / 2, img.texture.get_height())
		spr.init(255 / n * i + 100)

func _onAtkChara(atkInfo: AtkInfo):
	._onAtkChara(atkInfo)
	if atkInfo.atkType == AtkType.NORMAL and bl:
		bl = false
		atkInfo.hurtVal *= 2
		atkInfo.hitCha.addBuff(b_liuXue.new(5))
