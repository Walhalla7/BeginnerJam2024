extends Area2D

var speed = 190

@export var player_velocity: Vector2 = Vector2.ZERO
@export var group_name: String = "player"

# Called when the node enters the scene tree for the first time.
func _ready():
	area_entered.connect(_on_area_entered)

# Called every frame. 'delta' is the elapsed time since the previous frame.
var time_elapsed=0
func _process(delta):
	position += (player_velocity+(Vector2.RIGHT*speed).rotated(rotation))*delta
	time_elapsed+=delta
	if time_elapsed>2:
		queue_free()
	



func _on_visible_on_screen_enabler_2d_screen_exited():
	queue_free()



func _on_projectile_body_entered(body):
	#print("ENTERED BODY: ",body)
	queue_free()



func _on_area_entered(area):
	#print("ENTERED AREA: ",area)
	queue_free()
