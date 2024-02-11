extends Node

var take_item_ref : FuncRef

var remove_item_ref : FuncRef

func return_item_to_box(data):
	
	take_item_ref.call_func(data)
	print("return item")
	pass


func remove_item_from_box(data):
	
	remove_item_ref.call_func(data)
	print("remove item")
	pass
