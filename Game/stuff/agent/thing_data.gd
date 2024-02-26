class_name ThingData

extends Resource

var all_types = ["EXIT", "ITEM", "DANGER"]

export(String,"EXIT","ITEM","DANGER") var type 

export var one_shot : bool

var scene : Node

var global_position : Vector2

