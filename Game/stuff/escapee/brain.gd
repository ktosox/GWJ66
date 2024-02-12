extends Node

var stuff_to_do = []

var focus = 20

var go_to_place_ref : FuncRef

var 



func new_thing(data : ThingData):
	stuff_to_do
	pass





# Brain!
# is a finite state machine
# states for: going to "a point" / idle (keep startin IdleTimer and do random stuff) / sleeping (do notinhg until woken up)
# has priorities
# has a list of stuff to do

func wake_up():
	pass


func _on_ThingDetector_body_entered(body):
	assert(body.get("impression"))
	new_thing(body.impression)
	pass # Replace with function body.


func _on_IdleTimer_timeout():
	
	pass # Replace with function body.
