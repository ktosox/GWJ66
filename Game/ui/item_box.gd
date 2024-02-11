extends GridContainer

var item_stored_scene = load("res://ui/item_stored.tscn")

func _ready():
	var add_ref = FuncRef.new() as FuncRef
	add_ref.set_instance(self)
	add_ref.function = "add_item"
	IM.take_item_ref = add_ref
	
	var remove_ref = FuncRef.new() as FuncRef
	remove_ref.set_instance(self)
	remove_ref.function = "remove_item"
	IM.remove_item_ref = remove_ref
	
	pass
	
	
func remove_item(data : ItemData):
	for item in get_children():
		if item.color == data.color:
			item.queue_free()
	pass

func add_item(data : ItemData):
	var new_tem = item_stored_scene.instance()
	new_tem.load_item_data(data)
	new_tem.color = data.color
	add_child(new_tem)
	pass
