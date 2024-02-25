extends State



var look_around_ref : FuncRef

var got_to_random_ref : FuncRef



func enter(msg = {}):
	print("now I search")
	look_around_ref.call_func()
	pass



func looking_complete():
	got_to_random_ref.call_func()
	pass

func going_complete():
	look_around_ref.call_func()
	pass


func exit():
	
	pass
