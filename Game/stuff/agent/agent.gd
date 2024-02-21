extends Path2D

export var moving = false

export var stamina = 40

var max_stamina = 80

export var speed = 40




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
	
	match randi()%2:
		0:
			if $TumbleTimer.time_left > 0:
				$TumbleTimer.stop()
				un_tumble()
				yield(get_tree().create_timer(0.2),"timeout")
			$Torso/Label.text = "idle walking"
			move_to_point($Torso.global_position + Vector2(rand_range(-200,200),rand_range(-200,200) ))
			pass
		1:
			$Torso/Label.text = "tumble"
			tumble()
			$Torso.apply_central_impulse(Vector2(rand_range(-1,1),rand_range(-1,1)).normalized()*10)
			pass


func move_to_point(global_point : Vector2, urgency = 3.0):
	$Legs.offset = 0
	
	speed = stamina * urgency
	set_curve_from_path(get_path_to_point(Navigation2DServer.map_get_closest_point(GlobalNavigator.current_map,global_point)))

	
	moving = true

	pass




func _physics_process(delta):
	var endurance = 0.03
	if moving:
		
		$Legs.offset += delta * speed
		if $Legs/Mover.global_position != $Torso.global_position:
			$Torso/Eyes.look_at($Legs/Mover.global_position)
		var stamina_loss = delta * pow(speed,1.2) * endurance
		speed = speed - speed * (stamina_loss / max_stamina)
		stamina -= stamina_loss

		
	else:
		stamina = min(max_stamina, stamina + delta * 10)
	
	if $Legs.unit_offset == 1.0:
		moving = false

	if $Torso.position.distance_to($Legs.position) > 25 :
		tumble()
#		move_to_point(to_global(curve.get_point_position(curve.get_point_count()-1)) )

func tumble():
	if $TumbleTimer.time_left > 0:
		return
	moving = false
	$Legs/Joint.node_a = NodePath("")

	$TumbleTimer.start()
	pass

func un_tumble():
	#$Torso.mode = RigidBody2D.MODE_KINEMATIC
	
	$Legs.global_position = $Torso.global_position
	yield(get_tree().create_timer(0.2),"timeout")
	
	#$Legs/Mover.global_position = $Torso.global_position
	$Legs/Joint.set_deferred("node_a",NodePath("../Mover"))
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
	$Torso/Brain.do_something()
	pass


func _on_ItemGrabber_body_entered(body):
	
	pass # Replace with function body.




func _on_Torso_tree_exiting():
	queue_free()
	pass # Replace with function body.
