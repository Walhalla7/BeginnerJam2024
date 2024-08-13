extends Control

var currText = 0 

func _on_timer_timeout():
	match currText:
		0:
			$Text1.hide()
			$Text2.show()
		1:
			$Text2.hide()
			$Text3.show()
		2:
			$Text3.hide()
			SignalBus.intro_done.emit()
			queue_free()
	currText+=1
