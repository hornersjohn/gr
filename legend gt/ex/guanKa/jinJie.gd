extends Reference
class_name JinJie
var lv = 0

func init(lv):
	self.lv = lv
	sys.main.connect("onAddBatChara", self, "onAddBatChara")
	
func onAddBatChara(cha: Chara):
	var p = 0.2 * lv
	cha.attAdd.defL += p
	cha.attAdd.mgiDefL += p
	cha.attAdd.atkL += p
	cha.attAdd.mgiAtkL += p
	cha.attAdd.maxHpL += p
