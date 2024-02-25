extends Node

class_name StateMachine, "state_machine.svg"

export var initialState : NodePath

onready var state = get_node(initialState) as State


func _ready():
	yield(owner,"ready")
	for state in get_children():
		state.stateMachine = self
#		if c.get_child_count()>0: # check for child states
#			for d in c.get_children():
#				if d.is_class("State"):
#					d.manager = self
	activate_state()


func transition_to(targetState : String, msg = {}): # change state to targetState and pass to it msg
	assert(has_node(targetState) )
	yeet_state()
	state = get_node(targetState)
	activate_state(msg)



func activate_state(msg = {}):
	state.enter(msg)
	state.set_process(true)
	state.set_physics_process(true)


func yeet_state():
	state.set_process(false)
	state.set_physics_process(false)
	state.exit()
