extends Node

class_name RealmComponent 

#=================================================== VARIABLES ===========================================
#on ready variables
@onready var parent = self.get_parent()
@onready var collisions = _getCollisions()

#export variables 
@export_category("Sprite")
@export var sprite: Node2D
@export var AltSprite: Node2D

@export_category("Realm")
@export_enum("Default", "Alt1") var thisRealm:String = "Default"

#support variables
var hidden = false

#=================================================== ON READY  ===========================================
#we check what realm we are in and hide/show ourselves depending on it
func _ready():
	SignalBus.changeWorld.connect(changeRealm)
	
	if thisRealm != "Default":
		hideAll()
	else: 
		hidden = true
		showAll()

#=================================================== SIGNALS ===========================================
func changeRealm(newRealm):
	if newRealm != thisRealm:
		hideAll()
	else:
		showAll()

#=================================================== METHODS  ===========================================
#----------------------------------- COLLISIONS ---------------------------------
#looks for parent of component and returns all the collision shapes it has 
func _getCollisions():
	#print(parent.get_class())
	var allCollisions:Array = []
	for child in parent.get_children():
		var type = child.get_class()
		#print("parent: ", parent, ", child: ", child, ", child type: ", type)
		if ["CollisionPolygon2D", "CollisionShape2D"].has(type):
			#print("FOUND")
			allCollisions.append(child)  
	#print(allCollisions)
	return allCollisions
	#print("Parent Name: ", parent.name, ", visibility: ", parent.visible, ", paused: ", parent.get_tree().paused)

func disableCollisions():
	for collision in collisions:
		collision.disabled = true
		
	if (parent is TileMap) and (parent.is_in_group("RealmObstacle")):
		parent.set_layer_enabled(0, true)

func enableCollisions():
	for collision in collisions:
		collision.disabled = false

	if (parent is TileMap) and (parent.is_in_group("RealmObstacle")):
		parent.set_layer_enabled(0, false)
		
#----------------------------------- REALMS ---------------------------------
func hideAll():
	if !hidden:
		print("Hide")
		disableCollisions()
		if sprite:
			sprite.visible = false
		if AltSprite:
			AltSprite.visible = true
		parent.process_mode = PROCESS_MODE_DISABLED
		hidden = true

func showAll():
	if hidden:
		enableCollisions()
		if sprite:
			sprite.visible = true
		if AltSprite:
			AltSprite.visible = false
		parent.process_mode = PROCESS_MODE_INHERIT
		hidden = false
