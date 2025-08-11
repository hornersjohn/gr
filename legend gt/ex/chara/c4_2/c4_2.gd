extends "res://ex/chara/c4/c4.gd"

func _info():
	pass

func _extInit():
	._extInit()
	chaName = "荒原野兽"
	lv = 2
	attCoe.def += 1
	attCoe.maxHp += 2
	attCoe.atk += 2
	addSkillTxt("附近[流血]的单位死亡，恢复[流血]层数*15的生命值")
	

func _connect():
	._connect()
	
func _onCharaDel(cha):
	var bf = cha.hasBuff("b_liuXue")
	if bf != null and cha != self:
		plusHp(bf.life * 15)

