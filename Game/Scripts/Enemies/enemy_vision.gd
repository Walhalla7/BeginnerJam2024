extends Node



@onready var parent = get_parent() as CharacterBody2D
@onready var player = parent.player
@onready var in_area := $in_area as Area2D
@onready var ray_cast := $in_area/RayCast2D as RayCast2D


enum EnemyStates {ENEMY_CONTROL = 1, LAST_SEEN = 2, WANDERING = 3}
var enemy_state = EnemyStates.WANDERING

var searching_time=0.0

@onready var target_position=player.global_position



# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.




# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var bodies_in_area := in_area.get_overlapping_bodies()
	
	# if player in body
	var player_in_area=false
	for body in bodies_in_area:
		if body.is_in_group('player'):
			player_in_area=true
			break
			
	if enemy_state==1:
		in_area.look_at(player.global_position)
		in_area.rotate(-PI/2)
	elif enemy_state==2:
		in_area.look_at(target_position)
		in_area.rotate(-PI/2)
		
	if player_in_area:
		ray_cast.look_at(player.global_position)
		ray_cast.rotate(-PI/2)
		
		# if ray cast hits player set to enemy control
		var cast_collider=ray_cast.get_collider()
		if cast_collider:
			if cast_collider.is_in_group('player'):
				enemy_state=EnemyStates.ENEMY_CONTROL
				in_area.look_at(player.global_position)
				in_area.rotate(-PI/2)
				target_position=player.global_position
				searching_time=5.0
				return 
			
	if (enemy_state!=1) and ((parent.global_position-target_position).length()<10):
		searching_time=0	
	
	searching_time-=delta
	if searching_time>0:
		enemy_state=EnemyStates.LAST_SEEN
	else:
		enemy_state=EnemyStates.WANDERING
	
	
