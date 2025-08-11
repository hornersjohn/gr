extends "res://ex/chara/c8_2/c8_2.gd"

func _info():
	pass

func _extInit():
	._extInit()
	chaName = "影龙"
	lv = 3
	attCoe.atkRan = 2
	addSkillTxt("闪现至后排，普攻附带目标和自身70%法强的魔法伤害。")

func _connect():
	._connect()
	
func _onAtkChara(atkInfo: AtkInfo):
	._onAtkChara(atkInfo)
	if atkInfo.atkType == AtkType.NORMAL: hurtChara(atkInfo.hitCha, att.mgiAtk * 0.7 + atkInfo.hitCha.att.mgiAtk * 0.7, Chara.HurtType.MGI, Chara.AtkType.EFF)


func _onBattleStart():
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
		spr.texture = img.texture
		spr.position = position + s * (i + 1) * l.normalized() - Vector2(img.texture.get_width() / 2, img.texture.get_height())
		spr.init(255 / n * i + 100)
