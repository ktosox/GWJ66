extends KinematicBody2D

export var impression : Resource  # supposed to be thing_data.gd

var source : Node

func _ready():
	impression.scene = self

	pass

