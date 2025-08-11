extends Node2D
class_name Obj

var className = "Obj"

signal onAnimEnd(name)

signal onHit(atkInfo)
signal onPause(bl)

var cell = Vector2()
var mPos = Vector2()
var inputMove = Vector2()
var actLv = 0
var dire = 1
var stopTime = 0
var masCha = null


onready var spr = $spr
onready var anim = $AnimationPlayer
onready var normalSpr = $spr / normal
var atkBox = null
var sePlay = null
onready var pauseTimer = $ex / pauseTimer

var nowAnim = ""
var nowTime = 0.0
var ifDownInfo: IfInfo = IfInfo.new()
var ifFallInfo: IfInfo = IfInfo.new()
var atkInfo = AtkInfo.new()
var defStatus = 0
var atkIng = false

class IfInfo:
	extends Reference
	var anim = ""
	var time = 0
	var lv = 0

enum HurtType{PHY, MGI, REAL}
enum AtkType{NORMAL, SKILL, EFF, MISS}

func _ready():
	anim.connect("animation_finished", self, "animEnd")
	
	
	pauseTimer.connect("timeout", self, "pauseTimerRun")
	init()

var oldState = 0
var ghostTime = 0
var ghostOn = true
var airTime = 0
var downBl = false
var fallBl = true
func _physics_process(delta):
	_move_side(delta)
	if stopTime > 0:
		stopTime -= delta
		if stopTime <= 0:
			anim.playback_speed = 1
	else:
		nowTime += delta
	_up()
	
func _move_side(delta):
	position += mPos * delta
	
func move(x = 0, y = 0):
	mPos.x = x * dire
	mPos.y = y

func moveE(x = null, y = null):
	if x != null: mPos.x = x * dire
	if y != null: mPos.y = y
	
func atk(rate, x = 0, y = 0, pa = 0.05, pb = 0.05):
	atkBox.monitoring = true
	atkInfo.rate = rate
	atkInfo.x = x
	atkInfo.y = y
	atkInfo.pa = pa
	atkInfo.pb = pb
	atkInfo.atkCha = self
	pass

func offAtk():
	pass
	
func setDefSt(val):
	defStatus = val
	
func setActLv(lv):
	actLv = lv
	
func moveIn( var moveVector):
	mPos = moveVector * inputMove
	
func setDire(diref = 1):
	if diref == 0: return
	if diref > 0: dire = 1
	else: dire = - 1
	spr.scale.x = dire

func peneLk(on):






	pass

func ghostLk(on):
	ghostOn = on
	
func se(name, pitch = 1):
	sePlay.pitch_scale = pitch
	sePlay.stream = load("res://res/se/%s.wav" % name)
	sePlay.play()

func shake(uration, frequency, amplitude):
	sys.main.cam.shake(uration, frequency, amplitude)

func play(name, lv = 0, time = 0, spd = 1):
	if nowAnim != name:
		fallBl = true
		ifDownInfo.anim = ""
		atkIng = false
		defStatus = 0
		peneLk(false)
		ghostOn = false
	anim.play(name, - 1, spd)
	nowAnim = name
	actLv = lv
	stopTime = 0
	anim.seek(time)
	nowTime = time
	offAtk()


	_play()
	
func end():
	animEnd(nowAnim)
	
func stop(time = 1000.0):
	stopTime = time
	anim.playback_speed = 0
	
func ifDown(anim, lv, time):
	ifDownInfo.anim = anim
	ifDownInfo.lv = lv
	ifDownInfo.time = time
	
func animEnd(name):
	emit_signal("onAnimEnd", name)
	_animEnd()
	
func newEff(name, offset = Vector2(), isUi = false):
	var pos = position
	pos.y += 1
	var node = sys.newEff(name, pos, isUi, dire)
	node.normalSpr.position = offset
	if node as Obj:
		node.masCha = self.masCha
		node.dire = dire

	return node
	
func newEffIn(name, offset = Vector2(), isUi = false):
	var node = load("res://ex/eff/%s.tscn" % name).instance()
	normalSpr.add_child(node)
	if node as Obj:
		node.masCha = self.masCha
		node.dire = dire

	if node.normalSpr != null:
		node.normalSpr.position = offset
	return node
	
func getAnimTime():
	return anim.get_current_animation_pos()
	
func _on_Area2D_body_entered(body):
	if sys.isClass(masCha, "Chara") and sys.isClass(body, "Chara") and body != self and body != masCha and masCha.team != body.masCha.team:
		atkRun(body)
		
func atkRun(cha):
	atkInfo.atkCha = masCha
	atkInfo.atkObj = self
	atkInfo.hitCha = cha.masCha
	atkInfo.hitObj = cha
	masCha._atkIng(atkInfo)
	cha._hit(atkInfo)
	cha.emit_signal("onHit", atkInfo)
	self.pause(0.1)
	atkIng = true
		
func pause(time, shine = false):
	if time == 0: return
	
	
	if shine:
		$spr / normal / Sprite.use_parent_material = false
	self.shine = shine
	pauseTimer.start(time)
	emit_signal("onPause", true)
	
var shine = true
func pauseTimerRun():
	set_physics_process(true)
	anim.playback_speed = 1
	if shine:
		$spr / normal / Sprite.use_parent_material = true
	emit_signal("onPause", false)
	
func del():
	queue_free()

func _del():
	pass
	
func init():
	set_physics_process(true)
	set_process(true)
	show()
	offAtk()
	play("idle", actLv)

func _down():
	pass

func _fall():
	pass
	
func _animEnd():
	pass
	
func _up():
	pass
	
func _hit(atkInfo):
	pass

func _atkIng(atkInfo):
	pass
func _play():
	pass
