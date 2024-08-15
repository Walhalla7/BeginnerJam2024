extends Area2D


func _on_body_entered(body):
	SignalBus.emit_signal("Victory")


func _on_area_entered(area):
	SignalBus.emit_signal("Victory")
