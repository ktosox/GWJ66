extends ColorRect

var item_preview_scene = load("res://ui/item_preview.tscn")

var data : ItemData


# Called when the node enters the scene tree for the first time.
func _ready():

	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func get_drag_data(position):


	
	var preview = item_preview_scene.instance() as Control
	
	# make preview do stuff here
	preview.color = color
	
	set_drag_preview(preview)
	return data


func load_item_data(data : ItemData):
	self.data = data
	color = data.color
	pass
