extends Node2D

func _ready():
	var all_valid_tiles = $TileMap.get_used_cells()
	for tile in all_valid_tiles:
		var new_slot = load("res://ui/item_taker.tscn").instance()
#		$ItemTaker.rect_global_position
		new_slot.rect_global_position = tile * $TileMap.cell_size
		add_child(new_slot)
	pass
