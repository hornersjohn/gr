extends Node2D
class_name Eff

signal onReach()
signal onInCell(cell)

var posMove = Vector2()
var spr = null
onready var normalSpr = $spr / normal
var anim = null
var flyMode = 0
var flyCha = null
var flySpd = 200
var flyPos = Vector2()
var cell = Vector2()

func _ready():
	set_physics_process(false)
	spr = $spr
	anim = $AnimationPlayer
	anim.connect("animation_finished", self, "animation_finished")
	
func _physics_process(delta):
	var tPos = Vector2()
	if flyMode == 2:
		tPos = flyPos
		normalSpr.look_at(sys.main.scene.position + tPos + normalSpr.position)
		if sys.main.map.world_to_map(position) != cell:
			cell = sys.main.map.world_to_map(position)
			emit_signal("onInCell", cell)
	elif flyMode == 1:
		if sys.isClass(flyCha, "Chara"):
			tPos = flyCha.position
			if flyCha.is_inside_tree():
				normalSpr.look_at(flyCha.global_position + normalSpr.position)
		else:
			queue_free()
	if flyMode != 0:
		var lpos = tPos - position
		posMove = lpos.normalized() * flySpd
		position += posMove * delta
		
		if lpos.length() <= flySpd * delta:
			emit_signal("onReach")
			queue_free()
			
func _initFlyCha(cha, flySpd = 300):
	flyCha = cha
	flyMode = 1
	self.flySpd = flySpd
	scale.x = 1
	set_physics_process(true)

func _initFlyPos(pos, flySpd = 300):
	flyPos = pos
	self.cell = sys.main.map.world_to_map(pos)
	flyMode = 2
	self.flySpd = flySpd
	scale.x = 1
	set_physics_process(true)
	
func setNorPos(pos):
	if normalSpr != null: normalSpr.position = pos
	
func play(name):
	anim.play(name)
	
func move(x = 0, y = 0):
	posMove.x = x
	posMove.y = y
	set_physics_process(true)

func speed(s):
	posMove = posMove.normalized() * s
	
func pause(bl = true):
	if bl:
		anim.playback_speed = 0
		set_physics_process(false)
	else:
		anim.playback_speed = 1
		set_physics_process(true)

func animation_finished(anim_name):
	_del()
	anim_name = ""
	queue_free()
	
func _del():
	pass

func sprLookAt(pos):
	normalSpr.look_at(pos + normalSpr.position)
