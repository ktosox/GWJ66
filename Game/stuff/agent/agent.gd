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
	

func move_to_point(global_point : Vector2, urgency = 1.0):
	set_curve_from_path(get_path_to_point(Navigation2DServer.map_get_closest_point(GlobalNavigator.current_map,global_point)))
	$Legs.start_walking(urgency)
	#$Torso/Brain.look_at(global_point)
	pass


func _physics_process(delta):
	if $Legs.moving: #and !$Legs.walking_just_started:
		$Torso/Brain.look_at(curve.interpolate_baked($Legs.offset+10)+global_position)
		if $Torso.global_position.distance_to($Legs.global_position) > 15 :
			tumble()



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
	
	var go_to_point_ref = FuncRef.new()
	go_to_point_ref.set_instance(self)
	go_to_point_ref.function = "move_to_point"
	$Torso/Brain.go_to_point_ref = go_to_point_ref

	var trip_over_ref = FuncRef.new()
	trip_over_ref.set_instance(self)
	trip_over_ref.function = "tumble"
	$Torso.trip_over = trip_over_ref
	
	pass







func _on_Torso_tree_exiting():
	queue_free()
	pass # Replace with function body.



func _on_Legs_goal_reached():
	
	$Torso/Brain.walking_complete()
	pass # Replace with function body.
