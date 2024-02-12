extends Node

onready var current_map = Navigation2DServer.map_create()


#Navigation2DServer.map_set_edge_connection_margin(map,35) # this one increases range of polygons connecting


	

func reset_map():
	for region in Navigation2DServer.map_get_regions(current_map):
		Navigation2DServer.free_rid(region)
	Navigation2DServer.free_rid(current_map)
	pass

func register_navpoly(navpoly_to_register : NavigationPolygon):
	var region = Navigation2DServer.region_create()
	Navigation2DServer.region_set_map(region,current_map)
	Navigation2DServer.region_set_navpoly(region,navpoly_to_register)
	Navigation2DServer.map_force_update(current_map)
	return region # mostly returned so that travel cost can be changer later

