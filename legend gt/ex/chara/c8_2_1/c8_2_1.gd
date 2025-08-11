extends "res://ex/chara/c8_2/c8_2.gd"

func _info():
	pass

func _extInit():
	._extInit()
	chaName = "壳龙"
	lv = 3
	attCoe.maxHp += 1
	
	addSkillTxt("免疫所有负面状态！")

func _connect():
	._connect()

func _castCdSkill(id):
	._castCdSkill(id)

func _onAddBuff(buff: Buff):
	if buff.isNegetive:
		buff.isDel = true
