extends "res://ex/chara/c6_2/c6_2.gd"

func _info():
	pass

func _extInit():
	._extInit()
	chaName = "灵魂提灯者"
	lv = 3
	attCoe.atkRan = 3
	addSkillTxt("当有单位死亡:本次战斗+35攻击力")

func _connect():
	._connect()
	
func _onBattleStart():
	attAdd.atk = 0
	pass
	
func _onCharaDel(cha):
	._onCharaDel(cha)
	attAdd.atk += 35
