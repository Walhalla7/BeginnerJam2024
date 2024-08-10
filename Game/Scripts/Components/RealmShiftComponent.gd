extends Node

class_name RealmComponent 

@onready var parent = self.get_parent()

#======================================== 	Initialize 	==================================
func _ready():
	SignalBus.changeWorld.connect(shiftRealm)
	if parent.visible == false:
		parent.get_tree().paused = true 
	
#======================================== 	Functions for changing realms  	==================================
func shiftRealm():
	
	if parent.visible == false:
		parent.get_tree().paused = false 
		parent.visible = true
	else:
		parent.get_tree().paused = true 
		parent.visible = false
	
	print("Parent Name: ", parent.name, ", visibility: ", parent.visible, ", paused: ", parent.get_tree().paused)
