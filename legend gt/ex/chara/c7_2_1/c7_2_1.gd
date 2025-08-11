extends "res://ex/chara/c7_2/c7_2.gd"

func _info():
	pass

func _extInit():
	._extInit()
	chaName = "绿巨人"
	lv = 3
	attCoe.maxHp += 1.5
	
	addSkillTxt("任意角色召唤1个单位时，绿巨人永久+5生命值")

func _connect():
	._connect()

func _castCdSkill(id):
	._castCdSkill(id)
	
func _onCharaNewChara(cha):
	._onCharaNewChara(cha)
	attInfo.maxHp += 5
	upAtt()
