extends Path2D

var moving = false

var stamina = 20

var max_stamina = 30

var speed = 20




# note to self - temporarly detaching body from PinJoint might be a good idea when rag-dolling OR path reseting

func set_curve_from_path(path : PoolVector2Array):
	curve.clear_points()
	var SPREAD = 5 # 10 adds slight wobble - 100 is drunk
	for point in path:
		curve.add_point(point-global_position,Vector2(rand_range(-SPREAD,SPREAD),rand_range(-SPREAD,SPREAD)),Vector2(rand_range(-SPREAD,SPREAD),rand_range(-SPREAD,SPREAD)))
	
	pass




func get_path_to_point(target : Vector2):
	var start = $RigidBody2D.global_position

	return Navigation2DServer.map_get_path(GlobalNavigator.current_map,start,target,true)
	
func start_idle_behaviour():
	
	match randi()%2:
		0:
			$RigidBody2D/Label.text = "idle walking"
			move_to_point($RigidBody2D.global_position + Vector2(rand_range(-200,200),rand_range(-200,200) ))
			pass
		1:
			$RigidBody2D/Label.text = "idle nothhing"
			moving = false
			pass


func move_to_point(global_point : Vector2):
	$WhereToGo.offset = 0
	set_curve_from_path(get_path_to_point(Navigation2DServer.map_get_closest_point(GlobalNavigator.current_map,global_point)))
	moving = true

	pass




func _physics_process(delta):
	if moving:
		speed = stamina
		$WhereToGo.offset += delta * speed
		stamina -= delta
		
	else:
		stamina = min(max_stamina, stamina + delta * 8)
	
	if $WhereToGo.unit_offset == 1.0:
		moving = false
	
	if $RigidBody2D.position.distance_to($WhereToGo.position) > 45 :
		
		move_to_point(to_global(curve.get_point_position(curve.get_point_count()-1)) )

func _ready():
	curve = Curve2D.new()
	
	var idle_ref = FuncRef.new()
	idle_ref.set_instance(self)
	idle_ref.function = "start_idle_behaviour"
	$Brain.idle_around = idle_ref
	
	var go_to_ref = FuncRef.new()
	go_to_ref.set_instance(self)
	go_to_ref.function = "move_to_point"
	$Brain.go_to_point = go_to_ref
	$Brain.do_something()
	pass
