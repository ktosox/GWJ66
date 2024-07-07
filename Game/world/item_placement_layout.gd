extends TileMap

# job - places ItemTaker scenes based on tilemap

func _ready():
	test_make_items()
	pass


func test_make_items(item_count = 5):
	
	for c in item_count:
		var test_item_data = ItemData.new()
		test_item_data.color = ColorN("white")
		$ItemLayer/ItemBox.add_item(test_item_data)
		
	pass
