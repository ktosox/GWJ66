extends Node2D

var stuff_to_do = [] # Array of ThingData



var go_to_point : FuncRef

var idle_around : FuncRef

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
				go_to_point.call_func(next_thing_to_do.global_position)
				pass
			"ITEM":
				pass
			
		
	else:
		idle_around.call_func()
		$IdleTimer.start()
	sleeping = true
	pass


# Brain!
# is a finite state machine
# states for: going to "a point" / idle (keep startin IdleTimer and do random stuff) / sleeping (do notinhg until woken up)
# has priorities
# has a list of stuff to do

func wake_up():
	if sleeping:
		sleeping = false
		do_something()
	pass




func _on_IdleTimer_timeout():
	wake_up()
	pass # Replace with function body.


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


