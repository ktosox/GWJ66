extends KinematicBody2D

export var impression : Resource # supposed to be thing_data.gd



func _on_Escape_body_entered(body): # body is always 
	body.queue_free()
	pass # Replace with function body.


func _on_SuckZone_body_entered(body):

	pass # Replace with function body.
