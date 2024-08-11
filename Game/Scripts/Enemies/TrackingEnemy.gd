extends CharacterBody2D


const SPEED = 90.0

@export var player: Node2D

@onready var nav_agent := $NavigationAgent2D as NavigationAgent2D


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
	var current_agent_position =  global_position
	var next_path_position = nav_agent.get_next_path_position()
	velocity = current_agent_position.direction_to(next_path_position)*SPEED
	move_and_slide()
	
	# Update the target
	nav_agent.target_position=player.global_position
