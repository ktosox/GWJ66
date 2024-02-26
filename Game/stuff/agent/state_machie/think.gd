extends State

# THINK

var thinking = false

var think_time = 0

var make_choice_ref : FuncRef

# I need to re-vaualte this state
# it makes more sense to move over the logic over to Brain


func enter(msg = []):
	print("now I think")
	thinking = true
	if think_time <= 0:
		think_time = 0.2 + randf() * 0.4
	pass




func exit():
	
	pass





func _process(delta):
	if thinking:
		think_time -= delta
		if think_time <= 0:
			thinking = false
			make_choice_ref.call_func()
	pass
