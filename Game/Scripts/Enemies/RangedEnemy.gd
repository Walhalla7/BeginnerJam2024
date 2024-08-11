extends CharacterBody2D


const SPEED = 90.0

@export var player: Node2D

@onready var nav_agent := $NavigationAgent2D as NavigationAgent2D
@onready var ray_cast := $RayCast2D as RayCast2D

var projectile = preload("res://Scenes/Enemies/Projectile.tscn")


var shoot_timer=0

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
	ray_cast.look_at(player.global_position)
	ray_cast.rotate(-PI/2)
	if ((current_agent_position-player.global_position).length()>100) or (ray_cast.get_collider() is TileMap):
		velocity = current_agent_position.direction_to(next_path_position)*SPEED
	else:
		velocity=Vector2.ZERO
		
		# shooting
		$Marker2D.look_at(player.global_position)
		if shoot_timer<=0:
			var projectile_instance = projectile.instantiate()
			#projectile_instance.player_velocity = Vecto2.
			projectile_instance.rotation = $Marker2D.rotation
			projectile_instance.position = position		
			add_sibling(projectile_instance)
			shoot_timer=1
			
	shoot_timer-=delta
	move_and_slide()
	
	# Update the target
	nav_agent.target_position=player.global_position
