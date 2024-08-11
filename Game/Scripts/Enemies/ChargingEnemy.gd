extends CharacterBody2D


const SPEED = 75.0

@export var player: Node2D
@onready var nav_agent := $NavigationAgent2D as NavigationAgent2D
@onready var ray_cast := $RayCast2D as RayCast2D

var charging_time=0
var charging_bool=false
var charging_duration=3
var overshot_time=0
var restart_time=0

func _ready():
	call_deferred("seeker_setup")

func seeker_setup():
	await get_tree().physics_frame
	if player:
		nav_agent.target_position=player.global_position
		print("Targeting ", player.global_position)
		print(nav_agent.get_next_path_position())
	else:
		print("No Player")
		
		
		
		
		
func stop_charge() -> void:
		restart_time=0
		charging_time=charging_duration+1
		charging_bool=false
		print("STOPPING")
		
func check_head_on_collision(collision):
	var collision_normal = collision.get_normal()
	var movement_direction = -velocity.normalized()  # Assuming velocity is your movement vector

	# Calculate the dot product to determine how aligned the vectors are
	var alignment = collision_normal.dot(movement_direction)

	# Define a threshold for what you consider "mostly head-on"
	# 0.7 means roughly within a 45-degree cone
	var head_on_threshold = 0.3

	if alignment > head_on_threshold:
		stop_charge()
		

func _physics_process(delta):
	restart_time-=delta
	#print(nav_agent.get_next_path_position())

	
	#if nav_agent.is_navigation_finished():
		#return
		
	# Regular Movement paradigm
	
	#if ray_cast.is_colliding():
	if (ray_cast.get_collider() is CharacterBody2D):
		if (not charging_bool) and (restart_time<=0):
			speed=SPEED
			charging_bool=true
			charging_time=0
			print("CHARGING START")
		else:
			charging_time=0
			
	for i in get_slide_collision_count():
		#if get_slide_collision(i).get_collider():
			#stop_charge()
			
		var collision = get_slide_collision(i)
		var collider = collision.get_collider()
		if collider is TileMap:
			check_head_on_collision(collision)
	
	#charging_time+=delta
	#if charging_time>charging_duration:
		#stop_charge()
		
	#if ((position-player.global_position).length()>100) and charging_bool:
		#charging_time=charging_duration+1
		#charging_bool=false
		#print("STOPPING")
		
	# if not moving toward player for half second and charging stop charging
	if charging_bool and (abs(Vector2(0, 1).angle_to(to_local(player.global_position).normalized()))>PI/2):
		overshot_time+=delta
		if overshot_time>0.25:
			#print(abs(Vector2(0, 1).angle_to(to_local(player.global_position).normalized())))
			#print(to_local(player.global_position).normalized())
			#print(velocity)
			stop_charge()
	else:
		overshot_time=0
		
		
	
	
	
	if not charging_bool:
		var current_agent_position =  global_position
		var next_path_position = nav_agent.get_next_path_position()
		velocity = current_agent_position.direction_to(next_path_position)*SPEED
		var current_angle_vector=Vector2(sin(rotation), cos(rotation))
		var target_angle=current_angle_vector.angle_to(to_local(player.global_position).normalized())
		rotation=target_angle
	else:
		charge(delta)	
	move_and_slide()
	# Set Target to newest location
	nav_agent.target_position=player.global_position
		
		





var angle = Vector2.ZERO
var speed = 50
var turn_acceleration=0.0
var max_turn_acceleration = 9.81
var min_turn_radius=0.1

var turn_speed=15
var car_power=10000
var car_decel=30

#var turn_speed=30
#var car_power=100000
#var car_decel=2000

func charge(delta):
	var current_angle_vector=Vector2(sin(rotation), cos(rotation))
	var target_angle=current_angle_vector.angle_to(to_local(player.global_position).normalized())
	var target_angle_delta=target_angle-rotation
	
	var r
	r=(speed*speed)/(max_turn_acceleration)
	if (r<min_turn_radius) and (r>-min_turn_radius):
			r=min_turn_radius*sign(r)
			
	var possible_angle=(PI*delta/((PI*r)/speed))*turn_speed
	
	
	if abs(target_angle_delta)>abs(possible_angle):
		rotation+=sign(target_angle_delta)*possible_angle
	else:
		rotation+target_angle_delta

	# calculate from angle the velocity and speed
	velocity=Vector2.ZERO
	velocity.x=speed#*cos(-rotation)
	#velocity.y=10*cos(rotation)
	velocity.x=speed*sin(-rotation)
	velocity.y=speed*cos(-rotation)
	
	if delta*(car_power/speed)>car_decel:
		speed += delta*car_decel
	else:
		speed += delta*(car_power/speed)
