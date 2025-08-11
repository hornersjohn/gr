extends "res://ex/chara/c2/c2.gd"

func _info():
	pass

func _extInit():
	._extInit()
	chaName = "章鱼"
	lv = 2
	attCoe.def += 1
	attCoe.maxHp += 3
	evos = ["c2_1_1", "c2_1_2"]
	addSkillTxt("战斗开始时，周围一格内友军获得30点物理防御。")

func _connect():
	._connect()
	
func _onBattleStart():
	var chas = getCellChas(cell, 1, 2)
	for i in chas:
		if i != null: i.addBuff(Bf.new())

class Bf:
	extends Buff
	func _init():
		attInit()
		att.def = 30
