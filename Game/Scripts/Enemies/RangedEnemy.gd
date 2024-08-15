extends CharacterBody2D

const MAX_SPEED = 80.0
var SPEED = MAX_SPEED

@export var player: Node2D

@onready var nav_agent := $NavigationAgent2D as NavigationAgent2D
@onready var ray_cast := $RayCast2D as RayCast2D
@onready var enemy_vision := $EnemyVision as Node2D

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
	if enemy_vision.enemy_state<=2:
		if enemy_vision.enemy_state==2:
			SPEED = 45.0
		else:
			SPEED = MAX_SPEED
			
		if ((current_agent_position-player.global_position).length()>100) or (ray_cast.get_collider() is TileMap):
			var direction = (next_path_position - current_agent_position).normalized()
			velocity = direction * SPEED
		else:
			velocity=Vector2.ZERO
			
		if enemy_vision.enemy_state==1:
			# shooting
			$Marker2D.look_at(player.global_position)
			if shoot_timer<=0:
				var projectile_instance = projectile.instantiate()
				#projectile_instance.player_velocity = Vecto2.
				projectile_instance.rotation = $Marker2D.rotation
				projectile_instance.position = position		
				add_sibling(projectile_instance)
				shoot_timer=1
		move_and_slide()
	shoot_timer-=delta
	
	# Update the target
	nav_agent.target_position=enemy_vision.target_position
