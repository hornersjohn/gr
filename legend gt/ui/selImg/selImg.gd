extends Node2D

onready var node = $Node2D
onready var spr = $Sprite

func _ready():
	node.position = Vector2(0, 54 - 100)

func show():
	.show()
	if sys.main.selCha == null: return
	var ran = sys.main.selCha.att.atkRan
	
	for x in range( - ran, ran + 1):
		for y in range( - ran, ran + 1):
			if cellRan(Vector2(x, y), Vector2(0, 0)) <= ran:
				var spr = Sprite.new()
				spr.texture = preload("res://res/map/n.png")
				spr.position = Vector2(x * 100, y * 100)
				node.add_child(spr)

func hide():
	.hide()
	for i in node.get_children():
		i.queue_free()

func cellRan(v, cell = null):
	if cell == null: cell = self.cell
	var x = abs(cell.x - v.x)
	var y = abs(cell.y - v.y)
	return x + y

func setT(t):
	spr.texture = t
	spr.position.y = - spr.texture.get_height()
	spr.position.x = - spr.texture.get_width() * 0.5

func upSpr(pos):
	position = pos
