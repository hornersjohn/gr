extends Sprite




var a = 0

func _ready():
	pass




func init(a):
	self.a = a
	
func _process(delta):
	a -= delta * 200
	self_modulate = Color8(100, 100, 255, a)
	if a < 0:
		queue_free()
	
