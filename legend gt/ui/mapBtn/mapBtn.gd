extends TextureButton

var step = 0
onready var spr2 = $Sprite2
onready var anim = $AnimationPlayer

var tw = Tween.new()
func _ready():
	add_child(tw)

var w = 1.5
func setMap():
	step = 1
	anim.play("map")
	disabled = false
	
func setBat():
	step = 2
	anim.play("bat")
	disabled = false

func setNul():
	step = 0
	anim.play("null")
	disabled = true


func _on_Button_mouse_entered():
	tw.interpolate_property(self, "rect_scale", Vector2(1, 1), Vector2(w, w), 0.1, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tw.start()


func _on_Button_mouse_exited():
	tw.interpolate_property(self, "rect_scale", Vector2(w, w), Vector2(1, 1), 0.1, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tw.start()
