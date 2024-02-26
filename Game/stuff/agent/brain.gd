extends Node2D

# Brain!
# takes inputs from Agent and Torso and Senses
# decides what to do next

# is a finite state machine (WIP)

# RUNNING TO EXIT / GOING TO THING / SEARCHING

# has priorities (?)

# has a list of stuff to do

# should be on Torso so that it's connected to senses, and senses must be on Torso

var known_things = [] # Array of ThingData



var go_to_point_ref : FuncRef # method for going to places, takes global location and "urgency"



func _ready():
	$StateMachine.known_things = known_things
	
	var look_around_ref = FuncRef.new()
	look_around_ref.function = "look_around"
	look_around_ref.set_instance(self)
	$StateMachine/Search.look_around_ref = look_around_ref
	
	var got_to_random_ref = FuncRef.new()
	got_to_random_ref.function = "got_to_random"
	got_to_random_ref.set_instance(self)
	$StateMachine/Search.got_to_random_ref = got_to_random_ref
	
	
	var make_choice_ref = FuncRef.new()
	make_choice_ref.function = "make_a_choice"
	make_choice_ref.set_instance(self)
	$StateMachine/Think.make_choice_ref = make_choice_ref
	
	pass

func look_around():
	$Looker.stop()
	$Looker.play("look_around")
	pass

func got_to_random():
	$Looker.stop()
	$Looker.play("look_forward")
	go_to_point_ref.call_func(global_position + Vector2(rand_range(-150,150),rand_range(-150,150)),0.5)
	pass

func move_to(global_position :Vector2, importance : float):
	$Looker.stop()
	$Looker.play("look_forward")
	go_to_point_ref.call_func(global_position, importance)
	pass

func grabbed_thing(thing : ThingData):
	if thing.type == "ITEM":
		if known_things.has(thing):
			print("removing ",thing," from list")
			known_things.erase(thing)
		thing.scene.queue_free()
	pass

func noticed_thing(thing : ThingData):
	known_things.push_front(thing)
	if $StateMachine.state == $StateMachine.get_node("Search"):
		$StateMachine.transition_to("Think")
	pass

func forget_thing(thing : ThingData):
	if !known_things.has(thing):
		print("cant remove ", thing, " from list")
	known_things.erase(thing)
	print("removing ",thing," from list")
	pass


func make_a_choice():
	
	if known_things.empty():
		$StateMachine.transition_to("Search")
		return
		
		
		# importance evaluation should go here
	for thing in known_things:
		if thing.type == "EXIT":
			$StateMachine.transition_to("Escape")
			move_to(thing.global_position,3.0)
			return
				
#		match next_thing_to_do.type:
#			"EXIT":
#				$Thinks.text = "Im going to exit!"
#				go_to_point.call_func(next_thing_to_do.global_position,2)
#
#			"ITEM":
#				if !is_instance_valid(next_thing_to_do.scene):
#					stuff_to_do.erase(next_thing_to_do)
#					call_deferred("do_something")
#					return
#				$Thinks.text = "Im going to item!"
#				# does item exist?
#				go_to_point.call_func(next_thing_to_do.global_position)
#				look_at(next_thing_to_do.global_position)
#				pass
#			"SOUND":
#				if !is_instance_valid(next_thing_to_do.scene):
#					stuff_to_do.erase(next_thing_to_do)
#					call_deferred("do_something")
#					return
#				$Thinks.text = "Im going to sound!"
#				# does item exist?
#				go_to_point.call_func(next_thing_to_do.global_position)
#				look_at(next_thing_to_do.global_position)
#
#	else:
#		idle_around.call_func()
#		$Looker.stop()
#		$Looker.play("look_around")


	pass


func walking_complete():
	if $StateMachine.state == $StateMachine.get_node("Search"):
		$StateMachine/Search.going_complete()
	pass


func wake_up():
	if $StateMachine.state == $StateMachine.get_node("Sleep"):
		$StateMachine.state.sleep_time_over()

	pass


func sleep():
	$StateMachine.transition_to("Sleep")
	pass


func _on_Ears_body_entered(body):
	assert(body.get("impression"))
	if body.source == self: # ignore sound made by this enitiy
		return
	var thing = body.impression
	if known_things.has(thing):
		return
	noticed_thing(thing)
	pass # Replace with function body.



func _on_Eyes_body_entered(body):
	assert(body.get("impression"))
	var thing = body.impression
	if known_things.has(thing):
		return
	noticed_thing(thing)
	if thing.type == "EXIT":
		var scream = load("res://stuff/noise.tscn").instance()
		scream.global_position = global_position
		scream.impression.type = "EXIT"
		scream.impression.global_position = body.impression.global_position
		scream.source = self
		get_tree().current_scene.call_deferred("add_child",scream)
	
	pass # Replace with function body.


func _on_ItemGrabber_body_entered(body):
	assert(body.get("impression"))
	grabbed_thing(body.impression)
	pass # Replace with function body.


func _on_Looker_animation_finished(anim_name):
	if anim_name == "look_around" and $StateMachine.state == $StateMachine.get_node("Search"):
		$StateMachine/Search.looking_complete()
	pass # Replace with function body.
