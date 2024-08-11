extends AnimatedSprite2D

@export var tracking_enemy: Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if is_instance_valid(tracking_enemy):
		position = tracking_enemy.global_position
		rotation = tracking_enemy.rotation
	else:
		queue_free()
