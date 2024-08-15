extends CharacterBody2D

var MAX_SPEED = 80.0
var TURBO_SPEED=200.0
var ACCEL=5
var SPEED = MAX_SPEED
var prev_state=2

@export var player : Node2D

@onready var nav_agent := $NavigationAgent2D as NavigationAgent2D
@onready var in_area := $in_area as Area2D
@onready var ray_cast := $in_area/RayCast2D as RayCast2D


@onready var enemy_vision := $EnemyVision as Node2D

var chasing=false
var last_seen_position=position

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
		
func _physics_process(delta):
	#var bodies_in_area := in_area.get_overlapping_bodies()
	#if len(bodies_in_area)==0:
		#chasing=false
		#
		#
	#ray_cast.look_at(player.global_position)
	#ray_cast.rotate(-PI/2)
	#if (ray_cast.get_collider() is TileMap):
		#chasing=false
	#
	#in_area.look_at(player.global_position)
	#in_area.rotate(-PI/2)
	#print(enemy_vision.enemy_state)
	
	if enemy_vision.enemy_state<=2:
		if enemy_vision.enemy_state==2:
			SPEED = 45.0
		else:
			if prev_state!=enemy_vision.enemy_state:
				SPEED = MAX_SPEED
			else:
				SPEED+=ACCEL*delta
		var current_agent_position = position
		var next_path_position = nav_agent.get_next_path_position()
		var direction = (next_path_position - current_agent_position).normalized()
		velocity = direction * SPEED
		move_and_slide()
		
		# Update the target
		nav_agent.target_position=enemy_vision.target_position
		
	prev_state=enemy_vision.enemy_state
