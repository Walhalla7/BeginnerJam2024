extends Node2D

class_name HealthComponent 

#======================================== 	Variables 	==================================
@export var MAX_HEALTH := 5

var health : float

#======================================== 	Signals 	==================================
signal hurt
signal death

#======================================== 	Initialize 	==================================
func _ready():
	health = MAX_HEALTH
	SignalBus.damage_dealt.connect(receiveDamage)

#======================================== 	Functions for Health 	==================================	
func checkHealth():
	if health <= 0:
		death.emit()
	else:
		print(str(get_parent().name) + "'s health is " + str(health))
		hurt.emit()
		
func receiveDamage(dmg):
	health -= dmg
	checkHealth()
	

func decrement_health(damage: DamageComponent):
	health -= damage.damage_value
	checkHealth()
