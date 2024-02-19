extends Polygon2D


func _ready():
	$NavPoly.navpoly = NavigationPolygon.new()
	$NavPoly.navpoly.add_outline(polygon)
	$NavPoly.navpoly.make_polygons_from_outlines()
	GlobalNavigator.register_navpoly($NavPoly.navpoly)
