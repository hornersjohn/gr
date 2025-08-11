extends Node2D


var mas = null
onready var valSpr = $val
onready var valSpr2 = $val2
var offset = Vector2(0, 0)

func _ready():
	
	
	mas = get_node("../../")
	offset = position
	mas.connect("onHurtEnd", self, "runHurt")
	mas.connect("onPlusHp", self, "runPlusHp")
	mas.connect("onPause", self, "pause")
	mas.connect("onChangeTeam", self, "runChangeTeam")
	
	
func pause(bl = true):
	if bl:
		set_process(false)
		valSpr2.modulate = Color("ffffff")
	else:
		set_process(true)
		valSpr2.modulate = Color("e40000")
	
func _process(delta):
	
	if valSpr2.value > valSpr.value:
		valSpr2.value -= 300 * delta

func runHurt(atkInfo):
	valSpr.value = float(mas.att.hp) / mas.att.maxHp * 1000

func runPlusHp(val):
	valSpr.value = float(mas.att.hp) / mas.att.maxHp * 1000
	valSpr2.value = valSpr.value
	
func runChangeTeam(team):
	if mas.team == 1:
		valSpr.modulate = Color("6bdf65")
	else:
		valSpr.modulate = Color("ec5959")
