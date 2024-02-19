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
		var stamina_loss = delta * pow(speed,1.2) * endurance
		speed = speed - speed * (stamina_loss / max_stamina)
		stamina -= stamina_loss
		
	else:
		stamina = min(max_stamina, stamina + delta * 10)
	
	if $Legs.unit_offset == 1.0:
		moving = false
#
#	if $RigidBody2D.position.distance_to($Legs.position) > 45 :
#
#		move_to_point(to_global(curve.get_point_position(curve.get_point_count()-1)) )

func _ready():
	curve = Curve2D.new()
	
	var idle_ref = FuncRef.new()
	idle_ref.set_instance(self)
	idle_ref.function = "start_idle_behaviour"
	$RigidBody2D/Brain.idle_around = idle_ref
	
	var go_to_ref = FuncRef.new()
	go_to_ref.set_instance(self)
	go_to_ref.function = "move_to_point"
	$RigidBody2D/Brain.go_to_point = go_to_ref
	$RigidBody2D/Brain.do_something()
	pass


func _on_ItemGrabber_body_entered(body):
	
	pass # Replace with function body.
