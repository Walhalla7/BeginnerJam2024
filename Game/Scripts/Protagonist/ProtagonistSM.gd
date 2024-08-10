extends StateMachine

#function to handle jump input
func _input(event):
	if event.is_action("ChangeWorld") && parent.is_Grounded:
			SignalBus.emit_signal("changeWorld")

func _ready():
	#we add all the posible states to the list 
	add_state("IDLE")
	add_state("WALKING")
	call_deferred("set_state", states.IDLE)

#equivelent to process function
func _state_logic(delta):
	parent._handle_move_input()
	parent._apply_movement()
	parent._apply_gravity(delta)
	#uncomment below for testing
	print(states.keys()[state])

#conditions for transitioning between states
func _get_transition(delta):
	match state:
		#Leaving idle state
		states.IDLE:
			if parent.velocity.x != 0 || parent.velocity.y != 0:
				return states.WALKING
				
		#Leaving Walking state
		states.WALKING:
			if parent.velocity.x == 0 && parent.velocity.y == 0:
				return states.IDLE
				
	return null

#define behaviors while enetering into specific state
func _enter_state(new_state, old_state):
	match new_state:
		states.IDLE:
			pass
			
		states.WALKING:
			pass

#define behaviors while exiting out of specific state
func _exit_state(old_state, new_state):
	pass
