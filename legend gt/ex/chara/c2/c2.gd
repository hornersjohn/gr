extends Chara

func _info():
	pass

func _extInit():
	._extInit()
	chaName = "蜗牛"
	attCoe.atkRan = 1
	attCoe.maxHp = 3
	attCoe.atk = 3
	attCoe.mgiAtk = 3
	attCoe.def = 4
	attCoe.mgiDef = 3
	lv = 1
	evos = ["c2_1", "c2_2"]
	atkEff = "atk_dang"
	addSkillTxt("普通攻击20%概率使对手[失明]5秒")

func _connect():
	._connect()
func _onAtkChara(atkInfo: AtkInfo):
	._onAtkChara(atkInfo)
	if sys.rndPer(20): atkInfo.hitCha.addBuff(b_shiMing.new(5))
