extends CharacterBody2D

#======================================== 	Variables 	==================================
@onready var sprite = $Sprite2D

#Movement variables
@export var move_speed = 5.0
@export var lerp_speed = 0.2
#@export var JUMP_VELOCITY = 7
#var sprint_modifier = 1
#@export var max_sprint_modifier = 2

#======================================== 	Hurt & Death Functions 	==================================\

func _on_health_component_death():
	print("Player has died")
	SignalBus.emit_signal("game_over")

func _on_health_component_hurt():
	print("Player has been hurt")


#======================================== 	Movement 	==================================
#smooth out movement and perform checks on whether the player is grounded or not
func _apply_movement():
	# Flip Sprite
	if velocity.x > 0:
		sprite.flip_h = true
	elif velocity.x < 0:
		sprite.flip_h = false
		
	move_and_slide()

#function to calulcate directional inputs and movements 
func _handle_move_input():
	#we calculate movement direction based on inputs 
	var move_direction_x = int(Input.is_action_pressed("Right")) - int(Input.is_action_pressed("Left"))
	var move_direction_y = int(Input.is_action_pressed("Up")) - int(Input.is_action_pressed("Down"))

	# Sprint Input / calculations
	#sprint_modifier = max_sprint_modifier if Input.is_action_pressed("sprint") else 1
	
	#we apply the direction to velocity 
	velocity.x = lerp(velocity.x, move_direction_x * move_speed, lerp_speed)
	velocity.y = lerp(velocity.y, move_direction_y * move_speed, lerp_speed)

#======================================== 	Initialize 	==================================
func _ready():
	pass

#======================================== 	Process 	==================================
func _physics_process(delta):
	pass
