extends Node2D

# Brain!
# takes inputs from Agent and Torso and Senses
# decides what to do next

# is a finite state machine (WIP)

# has priorities (?)

# has a list of stuff to do

# should be on Torso so that it's connected to senses, and senses must be on Torso

var stuff_to_do = [] # Array of ThingData



var go_to_point : FuncRef # method for going to places, takes global location and "urgency"

var idle_around : FuncRef # makes the Agent do stuff, wakesup brain later

var sleeping = false

func _ready():
	
	pass

func new_thing(data : ThingData):
	# check if data is a duplicate
	# if not ->
	
	stuff_to_do.push_front(data)
	pass


func do_something():
	
	if !stuff_to_do.empty():
		var next_thing_to_do = stuff_to_do.front() as ThingData
		match next_thing_to_do.type:
			"EXIT":
				go_to_point.call_func(next_thing_to_do.global_position,3)
				pass
			"ITEM":
				go_to_point.call_func(next_thing_to_do.global_position)
				pass
			
		
	else:
		idle_around.call_func()
	
	sleep()
	pass



func wake_up():
	if sleeping:
		sleeping = false
		do_something()
	pass


func sleep():
	sleeping = true
	pass


func _on_Ears_body_entered(body):
	assert(body.get("impression"))
	body.impression.global_position = body.global_position # this is here becouse I got lazy and didnt want to make a generic "Thing" scene with a get_impression method
	new_thing(body.impression)
	pass # Replace with function body.



func _on_Eyes_body_entered(body):
	assert(body.get("impression"))
	body.impression.global_position = body.global_position # this is here becouse I got lazy and didnt want to make a generic "Thing" scene with a get_impression method
	new_thing(body.impression)
	pass # Replace with function body.


