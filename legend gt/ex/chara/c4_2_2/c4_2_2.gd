extends "res://ex/chara/c4_2/c4_2.gd"

func _info():
	pass

func _extInit():
	._extInit()
	chaName = "神兽白虎"
	lv = 3
	addSkillTxt("当周围1格内每少一个友军，物理攻击，物理防御，魔法防御，攻击速度 各提升10%，则最高提升40%")

func _connect():
	._connect()

var cells = [Vector2( - 1, 0), Vector2(1, 0), Vector2(0, 1), Vector2(0, - 1)]
func _upS():
	var rb = 0.4
	for i in cells:
		var cha = matCha(cell + i)
		if cha != null and cha.team == team:
			rb -= 0.1
	attAdd.atkL = rb
	attAdd.defL = rb
	attAdd.mgiDefL = rb
	attAdd.spd = rb
