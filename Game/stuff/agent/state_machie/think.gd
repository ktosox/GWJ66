extends State

# THINK

var thinking = false

var think_time = 0

var known_things : Array


func enter(msg = {}):
	print("now I think")
	thinking = true
	if think_time <= 0:
		think_time = 0.5 + randf()
	pass




func exit():
	
	pass

func make_a_choice():
	
	if known_things.empty():
		stateMachine.transition_to("Search")
		return
		
		
#		# importance evaluation should go here
#		var next_thing_to_do = stuff_to_do.front() as ThingData
#		for thing in stuff_to_do.size():
#			if stuff_to_do[thing].importance > next_thing_to_do.importance:
#				next_thing_to_do = stuff_to_do[thing]
#
#		match next_thing_to_do.type:
#			"EXIT":
#				$Thinks.text = "Im going to exit!"
#				go_to_point.call_func(next_thing_to_do.global_position,2)
#				look_at(next_thing_to_do.global_position)
#				pass
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



func _process(delta):
	if thinking:
		think_time -= delta
		if think_time <= 0:
			thinking = false
			make_a_choice()
	pass
