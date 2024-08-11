extends CharacterBody2D

#======================================== 	Variables 	==================================
@onready var sprite = $Sprite2D

#Movement variables
@export var move_speed = 20.0
@export var lerp_speed = 0.2


var projectile = preload("res://Scenes/Enemies/Projectile.tscn")

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
	var move_direction_y = -int(Input.is_action_pressed("Up")) + int(Input.is_action_pressed("Down"))

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
	
	# shooting
	var mouse_pos = get_global_mouse_position()
	$Marker2D.look_at(mouse_pos)
	if Input.is_action_just_pressed("L_Click"):
		var projectile_instance = projectile.instantiate()
		projectile_instance.player_velocity = velocity
		projectile_instance.rotation = $Marker2D.rotation
		projectile_instance.position = position	
		projectile_instance.collision_layer = 1
		projectile_instance.collision_mask = 2|3
		projectile_instance.group_name = "enemy"	
		add_sibling(projectile_instance)
