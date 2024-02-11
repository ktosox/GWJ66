extends Path2D


var map


func path_to_curve(path : PoolVector2Array):
	curve.clear_points()
	var SPREAD = 5 # 10 adds slight wobble - 100 is drunk
	for point in path:
		curve.add_point(point-global_position,Vector2(rand_range(-SPREAD,SPREAD),rand_range(-SPREAD,SPREAD)),Vector2(rand_range(-SPREAD,SPREAD),rand_range(-SPREAD,SPREAD)))
	
	pass


func get_path_to_point(target : Vector2):
	var start = to_global($WhereToGo.position)
	print(start, " : ",target)
	return Navigation2DServer.map_get_path(map,start,target,true)
	


func move_to_point(global_point : Vector2, map):
	self.map = map
	path_to_curve(get_path_to_point(global_point))
	$AnimationPlayer.stop()
	$AnimationPlayer.play("New Anim")
	print(curve._data)
	pass

func _ready():
	
	pass
