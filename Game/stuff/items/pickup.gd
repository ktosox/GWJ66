extends KinematicBody2D

export var impression : Resource  # supposed to be thing_data.gd

export var type : int


func _ready():
	impression.scene = self
	impression.global_position = global_position
	pass
