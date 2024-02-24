extends RigidBody2D

var trip_over : FuncRef

func bump(force = 1.0):
	trip_over.call_func()
	pass

func get_saved():
	queue_free()
	pass
