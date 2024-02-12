extends Path2D


# note to self - temporarly detaching body from PinJoint might be a good idea when rag-dolling OR path reseting

func path_to_curve(path : PoolVector2Array):
	curve.clear_points()
	var SPREAD = 5 # 10 adds slight wobble - 100 is drunk
	for point in path:
		curve.add_point(point-global_position,Vector2(rand_range(-SPREAD,SPREAD),rand_range(-SPREAD,SPREAD)),Vector2(rand_range(-SPREAD,SPREAD),rand_range(-SPREAD,SPREAD)))
	
	pass


func get_path_to_point(target : Vector2):
	var start = ($RigidBody2D.global_position + $WhereToGo.global_position)/2

	return Navigation2DServer.map_get_path(GlobalNavigator.current_map,start,target,true)
	


func move_to_point(global_point : Vector2):
	path_to_curve(get_path_to_point(global_point))
	$AnimationPlayer.stop()
	$AnimationPlayer.play("New Anim")

	pass

func _physics_process(delta):

	if $RigidBody2D.position.distance_to($WhereToGo.position) > 45 :
		
		move_to_point(to_global(curve.get_point_position(curve.get_point_count()-1)) )

func _ready():
	
	pass
