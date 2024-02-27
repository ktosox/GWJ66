extends State

# SLEEP

var sleep_time = 0 # set this to a custom value to make brain sleep this long

var sleeping = false





func enter(msg = []):
	print("now I sleep")
	if msg.size() > 0:
		sleep_time = msg[0]
	if sleep_time <= 0:
		sleep_time = 1 + randf()
	sleeping = true
	pass




func exit():
	
	pass


func sleep_time_over():
	
	# switch to "think what's next" state
	stateMachine.transition_to("Think")
	pass


func _process(delta):
	if sleeping:
		sleep_time -= delta
		if sleep_time <= 0:
			sleeping = false
			sleep_time_over()
	pass
