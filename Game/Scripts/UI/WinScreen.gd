extends Control

#Preloading Scene
var main = preload("res://Scenes/World/CombinedRealms.tscn")

#Hide and only show up when signal is received 
func _ready():
	hide()
	SignalBus.Victory.connect(Victory)

#Show screen when player dies
func Victory():
	show()
	for child in get_parent().get_children():
		if child.name == "CombinedRealms":
			child.queue_free()
			break
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

#reset main scene
func _on_reset_button_pressed():
	Input.mouse_mode = Input.MOUSE_MODE_HIDDEN
	hide()
	var newLevel_instance = main.instantiate()
	get_parent().add_child(newLevel_instance)

#quit game
func _on_quit_button_pressed():
	get_tree().quit()
