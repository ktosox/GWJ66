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


func grabbed_thing(thing : ThingData):
	if thing.type == "ITEM":
		if stuff_to_do.has(thing):
			print("removing ",thing," from list")
			stuff_to_do.erase(thing)
		thing.scene.queue_free()
	pass

func noticed_thing(thing : ThingData):
	
	# check if data is a duplicate
	if stuff_to_do.has(thing):
		return
	if thing.type == "EXIT":
		print("I noticed a : ", thing.type)
		var scream = load("res://stuff/noise.tscn").instance()
		scream.global_position = global_position
		scream.impression.global_position = thing.global_position
		scream.source = self
		get_tree().current_scene.call_deferred("add_child",scream)
	stuff_to_do.push_front(thing)

	pass


func do_something():
	
	if !stuff_to_do.empty():
		# importance evaluation should go here
		var next_thing_to_do = stuff_to_do.front() as ThingData
		for thing in stuff_to_do.size():
			if stuff_to_do[thing].importance > next_thing_to_do.importance:
				next_thing_to_do = stuff_to_do[thing]

		match next_thing_to_do.type:
			"EXIT":
				$Thinks.text = "Im going to exit!"
				go_to_point.call_func(next_thing_to_do.global_position,2)
				pass
			"ITEM":
				if !is_instance_valid(next_thing_to_do.scene):
					stuff_to_do.erase(next_thing_to_do)
					call_deferred("do_something")
					return
				$Thinks.text = "Im going to item!"
				# does item exist?
				go_to_point.call_func(next_thing_to_do.global_position)
				pass
			"SOUND":
				if !is_instance_valid(next_thing_to_do.scene):
					stuff_to_do.erase(next_thing_to_do)
					call_deferred("do_something")
					return
				$Thinks.text = "Im going to sound!"
				# does item exist?
				go_to_point.call_func(next_thing_to_do.global_position)
		
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
	if body.source == self: # ignore sound made by this enitiy
		return
	noticed_thing(body.impression)
	pass # Replace with function body.



func _on_Eyes_body_entered(body):
	assert(body.get("impression"))
	noticed_thing(body.impression)
	pass # Replace with function body.


func _on_ItemGrabber_body_entered(body):
	assert(body.get("impression"))
	grabbed_thing(body.impression)
	pass # Replace with function body.
