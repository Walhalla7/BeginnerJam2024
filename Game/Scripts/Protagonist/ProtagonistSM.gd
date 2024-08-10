extends StateMachine

#function to handle jump input
func _input(event):
	if event.is_action_released("ChangeWorld"):
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
	#uncomment below for testing
	#print(states.keys()[state])
	#print("x: ", parent.velocity.x, ", y: ", parent.velocity.y)

#conditions for transitioning between states
func _get_transition(delta):
	match state:
		#Leaving idle state
		states.IDLE:
			if abs(int(parent.velocity.x)) != 0 || abs(int(parent.velocity.y)) != 0:
				return states.WALKING
				
		#Leaving Walking state
		states.WALKING:
			if abs(int(parent.velocity.x)) < 0.9 && abs(int(parent.velocity.y)) < 0.9 :
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
