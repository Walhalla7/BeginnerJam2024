extends Node

class_name RealmComponent 

@onready var parent = self.get_parent()
@export var collisionShape:CollisionShape2D

#======================================== 	Initialize 	==================================
func _ready():
	SignalBus.changeWorld.connect(shiftRealm)
	if parent.visible == false:
		if collisionShape:
			collisionShape.disabled = true
		parent.get_tree().paused = true 
	else:
		parent.get_tree().paused = false 
		if collisionShape:
			collisionShape.disabled = false
	
#======================================== 	Functions for changing realms  	==================================
func shiftRealm():
	
	if parent.visible == false:
		if collisionShape:
			collisionShape.disabled = false
		parent.get_tree().paused = false 
		parent.visible = true
	else:
		if collisionShape:
			collisionShape.disabled = true
		parent.get_tree().paused = true 
		parent.visible = false
	
	print("Parent Name: ", parent.name, ", visibility: ", parent.visible, ", paused: ", parent.get_tree().paused)
