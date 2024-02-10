extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var map

# Called when the node enters the scene tree for the first time.
func _ready():
	map = Navigation2DServer.get_maps()[0]
	Navigation2DServer.map_set_edge_connection_margin(map,35) # this one increases range of polygons connecting
	
	Navigation2DServer.map_force_update(map) # this one is needed if I dont call a diffrent function like the one above
	
#	var region = Navigation2DServer.region_create()
#	var region2 = Navigation2DServer.region_create()
#	Navigation2DServer.region_set_map(region,map)
#	Navigation2DServer.region_set_map(region2,map)
	#Navigation2DServer.region_set_navpoly(region,$NavigationPolygonInstance.navpoly)
	#Navigation2DServer.region_set_navpoly(region2,$NavigationPolygonInstance2.navpoly)
#	print(Navigation2DServer.region_get_connections_count(region) )
	




	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#$Icon.position = Navigation2DServer.map_get_closest_point(map,get_local_mouse_position())
	var points = Navigation2DServer.map_get_path(map,$Icon.position,Navigation2DServer.map_get_closest_point(map,get_local_mouse_position()),true)
	$Line2D.points = points
	
	pass
