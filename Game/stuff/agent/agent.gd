extends Path2D






# note to self - temporarly detaching body from PinJoint might be a good idea when rag-dolling OR path reseting

func set_curve_from_path(path : PoolVector2Array):
	curve.clear_points()
	var SPREAD = 10 # 10 adds slight wobble - 100 is drunk
	for point in path:

		curve.add_point(point-global_position,Vector2(rand_range(-SPREAD,SPREAD),rand_range(-SPREAD,SPREAD)),Vector2(rand_range(-SPREAD,SPREAD),rand_range(-SPREAD,SPREAD)))
	
	pass


func get_path_to_point(target : Vector2):
	var start = $Torso.global_position

	return Navigation2DServer.map_get_path(GlobalNavigator.current_map,start,target,true)
	
func start_idle_behaviour():
	move_to_point($Torso.global_position + Vector2(rand_range(-20,20),rand_range(-20,20)),0.5)
	yield(get_tree().create_timer(1.5),"timeout")
	$Torso/Brain.wake_up()
	pass


func move_to_point(global_point : Vector2, urgency = 1.0):
	set_curve_from_path(get_path_to_point(Navigation2DServer.map_get_closest_point(GlobalNavigator.current_map,global_point)))
	$Legs.start_walking(urgency)

	pass






func tumble():
	if $TumbleTimer.time_left > 0:
		return
	$Legs.fall()
	$Torso/Brain.sleep()
	$TumbleTimer.start()
	pass

func un_tumble():
	#$Torso.mode = RigidBody2D.MODE_KINEMATIC
	
	$Legs.global_position = $Torso.global_position
	yield(get_tree().create_timer(0.2),"timeout")
	$Legs.un_fall()
	#$Legs/Mover.global_position = $Torso.global_position
	
	$Torso/Brain.wake_up()
	#$Torso.set_deferred("mode",RigidBody2D.MODE_CHARACTER) 
	pass

func _ready():
	curve = Curve2D.new()
	
	var idle_ref = FuncRef.new()
	idle_ref.set_instance(self)
	idle_ref.function = "start_idle_behaviour"
	$Torso/Brain.idle_around = idle_ref
	
	var go_to_ref = FuncRef.new()
	go_to_ref.set_instance(self)
	go_to_ref.function = "move_to_point"
	$Torso/Brain.go_to_point = go_to_ref

	var trip_over_ref = FuncRef.new()
	trip_over_ref.set_instance(self)
	trip_over_ref.function = "tumble"
	$Torso.trip_over = trip_over_ref
	
	$Torso/Brain.do_something()
	pass



func _physics_process(delta):
	if $Legs.global_position.distance_to($Torso.global_position) > 1.0 :
		
		$Torso/Eyes.look_at($Legs.global_position)



func _on_ItemGrabber_body_entered(body):
	$Torso/Brain.wake_up()
	pass # Replace with function body.




func _on_Torso_tree_exiting():
	queue_free()
	pass # Replace with function body.



func _on_Legs_goal_reached():
	$Torso/Brain.wake_up()
	pass # Replace with function body.
