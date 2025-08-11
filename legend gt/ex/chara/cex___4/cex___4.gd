extends Chara

func _info():
	pass

func _extInit():
	._extInit()
	chaName = "深海巨鲸-传奇"
	lv = 4
	attCoe.atkRan = 1
	attCoe.maxHp = 7
	attCoe.atk = 6
	attCoe.mgiAtk = 5
	attCoe.def = 6
	attCoe.mgiDef = 6
	atkEff = "atk_dao"
	addCdSkill("c4_1_1", 7)
	addSkillTxt("每7秒，对3个法强最高敌方单位造成200%物理伤害，并附加10层[流血]")
	addCdSkill("c4_1_2", 10)
	addSkillTxt("每10秒，恢复自身及生命值百分比最低的友方随从17%生命值。")
	addSkillTxt("攻击[流血]单位时，获得[急速]和[狂怒]，层数等于目标身上[流血]层数")
	addSkillTxt("当周围1格内每少一个友军，物理攻击，物理防御，魔法防御，攻击速度 各提升10%，则最高提升40%")

var baseId = ""


func _connect():
	._connect()

func _onAtkChara(atkInfo):
	._onAtkChara(atkInfo)
	if atkInfo.atkType == AtkType.NORMAL:
		var bf = atkInfo.hitCha.hasBuff("b_liuXue")
		if bf != null:
			addBuff(b_jiSu.new(5)).life = bf.life
			addBuff(b_kuangNu.new(5)).life = bf.life
			
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

func _castCdSkill(id):
	._castCdSkill(id)
	if id == "c4_1_1":
		var chas = getAllChas()
		chas.sort_custom(self, "sort")
		for i in range(3):
			if i >= chas.size(): break
			var cha: Chara = chas[i]
			fx(cha)
			
	if id == "c4_1_2":
		var cha = null
		var m = 10000
		var chas = getAllChas(2)
		for i in chas:
			if i.att.hp / i.att.maxHp < m:
				cha = i
				m = i.att.hp / i.att.maxHp
		if cha != null: cha.plusHp(cha.att.maxHp * 0.17)
		self.plusHp(self.att.maxHp * 0.17)

func sort(a, b):
	if a.att.mgiAtk > b.att.mgiAtk:
		return true
	return false

func fx(cha):
	var d: Eff = newEff("sk_4_1_2", sprcPos)
	d._initFlyCha(cha)
	yield(d, "onReach")
	if sys.isClass(cha, "Chara"):
		hurtChara(cha, att.atk * 2)
		cha.addBuff(b_liuXue.new(10))
