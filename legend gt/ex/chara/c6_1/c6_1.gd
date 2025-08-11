extends "res://ex/chara/c6/c6.gd"

func _info():
	pass

func _extInit():
	._extInit()
	chaName = "骷髅兵"
	lv = 2
	attCoe.atk += 1
	attCoe.mgiDef = 4
	attCoe.maxHp = 5
	addSkillTxt("濒临死亡复活1次，恢复70%生命值")

func _connect():
	._connect()

var n = 0
func _onBattleStart():
	n = 0
	pass

func _onDeath(atkInfo):
	._onDeath(atkInfo)
	if n < 1 and isDeath:
		n += 1
		isDeath = false
		plusHp(att.maxHp * 0.7)

