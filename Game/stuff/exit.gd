extends KinematicBody2D

export var impression : Resource # supposed to be thing_data.gd

func _ready():
	impression.scene = self
	impression.global_position = global_position

func _on_Escape_body_entered(body): # body is always 
	body.get_saved()
	pass # Replace with function body.


func _on_SuckZone_body_entered(body):
	body.bump()
	pass # Replace with function body.
