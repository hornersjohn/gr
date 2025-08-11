extends Item
	
func init():
	name = "碑文盾"
	type = config.EQUITYPE_EQUI
	attInit()
	att.maxHp = 300
	att.def = 40
	att.mgiDef = 50
	info = "释放技能时，恢复自身及生命值百分比最低的友方随从10%生命值。。"

func _connect():
	masCha.connect("onCastCdSkill", self, "run")

func run(id):
	var cha = null
	var m = 10000
	var chas = masCha.getAllChas(2)
	for i in chas:
		if i.att.hp / i.att.maxHp < m:
			cha = i
			m = i.att.hp / i.att.maxHp
	if cha != null: cha.plusHp(cha.att.maxHp * 0.1)
	masCha.plusHp(masCha.att.maxHp * 0.1)
