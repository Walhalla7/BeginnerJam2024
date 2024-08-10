extends StateMachine


func _ready():
	#we add all the posible states to the list 
	add_state("IDLE")
	call_deferred("set_state", states.IDLE)

#equivelent to process function
func _state_logic(delta):
	parent._apply_movement()
	#uncomment below for testing
	#print(states.keys()[state])
	#print("x: ", parent.velocity.x, ", y: ", parent.velocity.y)

#conditions for transitioning between states
func _get_transition(delta):
	pass

#define behaviors while enetering into specific state
func _enter_state(new_state, old_state):
	pass

#define behaviors while exiting out of specific state
func _exit_state(old_state, new_state):
	pass
