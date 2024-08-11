extends Area2D

class_name HitboxComponent

@export var health_component : HealthComponent
#
#@export var hitboxshape : CollisionShape2D
#
##@onready $CollisionShape2D = hitboxshape
#
#func _ready():
	#if hitboxshape:
		#var newColl:CollisionShape2D = hitboxshape
		#add_child(newColl)
		#$CollisionShape2D.shape = hitboxshape

# Call to the healthcomponent to decrement health value by damage value
func decrement_health(damage: DamageComponent):
	if health_component:
		health_component.decrement_health(damage)

func _find_dmg_component(body):
	for child in body.get_children():
		#print("TEST: ",child.name)
		if child.name == "DamageComponent":
			return child
	return null

# When the collision for an object to do damage enters the obj to be damaged
func _on_body_entered(body):
	print(body.name, " HIT")
	var damageComponent = _find_dmg_component(body)
	if damageComponent:
		decrement_health(damageComponent)		



func _on_area_entered(area):
	print(area.name, " HIT")
	var damageComponent = _find_dmg_component(area)
	if damageComponent:
		decrement_health(damageComponent)
