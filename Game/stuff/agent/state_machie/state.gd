class_name State, "state.svg"

extends Node

var stateMachine

func _ready():
	set_process(false)
	set_physics_process(false)
	yield(owner,"ready")

func enter(msg = []):
	
	pass




func exit():
	
	pass

