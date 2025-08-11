extends Control




var player: Player = null


func _ready():
	pass



func init(player):
	self.player = player
	player.connect("onPlusLv", self, "upLv")
	player.connect("onChangeHp", self, "upHp")
	upLv()
	upHp(0)

func upLv():
	if player.lv <= 8:
		$GridContainer.get_child(player.lv - 1).setStage(1)

func upHp(val):
	$hp.text = "%s:%d/%d" % [tr("生命"), player.hp, player.maxHp]
