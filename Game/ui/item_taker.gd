extends ColorRect

var data : ItemData

var empty_color : Color


# Called when the node enters the scene tree for the first time.
func _ready():
	
	empty_color = color
	pass # Replace with function body.

func can_drop_data(position, data):
	
	var to_return = true
	# data validation goes here

	if self.data != null:
		to_return = false
	
	return to_return

func drop_data(position, data):
	
	# handle drop of data
	self.data = data
	color = data.color
	IM.remove_item_from_box(data)
	pass




func _on_ItemSlot_gui_input(event : InputEvent):
	if event.is_pressed() and data != null:
		color = empty_color
		IM.return_item_to_box(data)
		data = null
		
	pass # Replace with function body.
