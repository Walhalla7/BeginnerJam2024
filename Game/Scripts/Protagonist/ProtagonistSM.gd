extends StateMachine

#------------------------------- REALM MANAGMENT -------------------------------
var currRealm = 2
var warpReady = true

@onready var RealmTimer = $"../RealmCooldown"

func _on_realm_cooldown_timeout():
	warpReady = true

#function to handle jump input
#func _input(event):
	#if event.is_action_released("ChangeWorld"):
		#currRealm -= 1
		#if currRealm < 1:
			#currRealm = 3
		#match currRealm:
			#1: 
				#SignalBus.emit_signal("changeWorld", "Alt1")
			#2:
				#SignalBus.emit_signal("changeWorld", "Default")
			#3:
				#SignalBus.emit_signal("changeWorld", "Alt2")
		#
	#if event.is_action_released("ChangeWorld1"):
		#currRealm += 1
		#if currRealm > 3:
			#currRealm = 1
		#match currRealm:
			#1: 
				#SignalBus.emit_signal("changeWorld", "Alt1")
			#2:
				#SignalBus.emit_signal("changeWorld", "Default")
			#3:
				#SignalBus.emit_signal("changeWorld", "Alt2")
				
				
func _input(event):
	if event.is_action_released("ChangeWorld") and warpReady:
		warpReady = false
		RealmTimer.start()
		currRealm -= 1
		if currRealm < 1:
			currRealm = 2
		match currRealm:
			1: 
				SignalBus.emit_signal("changeWorld", "Alt1")
			2:
				SignalBus.emit_signal("changeWorld", "Default")
		
	#if event.is_action_released("ChangeWorld1"):
		#currRealm += 1
		#if currRealm > 2:
			#currRealm = 1
		#match currRealm:
			#1: 
				#SignalBus.emit_signal("changeWorld", "Alt1")
			#2:
				#SignalBus.emit_signal("changeWorld", "Default")
			#3:
				#SignalBus.emit_signal("changeWorld", "Alt2")
				

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



