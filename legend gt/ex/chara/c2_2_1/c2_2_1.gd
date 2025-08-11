extends "res://ex/chara/c2_2/c2_2.gd"

func _info():
	pass

func _extInit():
	._extInit()
	chaName = "触手长枪使"
	lv = 3
	evos = []
	attAdd.suck += 0.3
	attCoe.maxHp += 1
	attCoe.atkRan = 1
	addSkillTxt("获得30%攻击吸血.普攻时目标身后的一格的敌人也承受一次普攻。")

func _connect():
	._connect()

func _onNormalAtk(cha):
	var cc: Vector2 = cell + (cha.cell - cell).normalized() * 2
	var ca = matCha(cc)
	if ca != null and ca.team != team:
		hurtChara(ca, att.atk * 1.0, Chara.HurtType.PHY, Chara.AtkType.NORMAL)
