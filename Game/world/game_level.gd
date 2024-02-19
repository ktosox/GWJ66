extends Node2D

func _ready():
	$NavigationPolygonInstance.navpoly.add_outline($Polygon2D.polygon)
	$NavigationPolygonInstance.navpoly.make_polygons_from_outlines()
	GlobalNavigator.register_navpoly($NavigationPolygonInstance.navpoly)
