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

# When the collision for an object to do damage enters the obj to be damaged
func _on_body_entered(body):
	print(body.name, " HIT")
	if body.damage_component:
		decrement_health(body.damage_component)		



func _on_area_entered(area):
	print(area.name, " HIT")
	if area.damage_component:
		decrement_health(area.damage_component)
