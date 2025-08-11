extends "res://ui/msgBaseX/msgBaseX.gd"





var hq: HTTPRequest = null
var item = null


func _ready():
	pass

func init(s):
	$Label.text = s
	$Button.text = "放弃"
	popup()
	$Timer.start()
	
func end(s, st = 0):
	$Label.text = s
	$Button.text = "完成"
	if st == 0:
		$HTTPRequest.request("https://lc-3gbiznhs83f8175f-1302941602.ap-shanghai.service.tcloudbase.com/plusFln?id=%s" % item._id)

func _on_Button_pressed():
	hq.cancel_request()
	queue_free()

func _on_Timer_timeout():
	$Label2.text = "%.2f M / %.2f M" % [hq.get_downloaded_bytes() / 1024.0 / 1024.0, hq.get_body_size() / 1024.0 / 1024.0]
