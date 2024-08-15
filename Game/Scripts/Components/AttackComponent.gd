extends Area2D

@onready var attackTimer = $attackTime
@onready var cooldownTimer = $Cooldown

@export var attackTime: float = 1
@export var cooldownTime: float = 1
@export var Damage: float = 1
@export var AttackAnimation: Animation

var inRange = false
var midAnimation = false

# When the collision for an object to do damage enters the obj to be damaged
func _on_body_entered(body):
	print("ENTERED")
	inRange = true
	if !midAnimation:
		midAnimation = true
		attackTimer.start()
		if AttackAnimation:
			AttackAnimation.play()
	


func _on_body_exited(body):
	print("EXITES")
	inRange = false 


func _on_attack_time_timeout():
	print("TIMEOUT")
	if inRange:
		SignalBus.emit_signal("damage_dealt", Damage)
		cooldownTimer.start()


func _on_cooldown_timeout():
	print("READY")
	midAnimation = false
	if inRange:
		midAnimation = true
		attackTimer.start()
		if AttackAnimation:
			AttackAnimation.play()
