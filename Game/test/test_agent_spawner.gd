extends Node2D


var agent_scene = preload("res://stuff/agent/agent.tscn")


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Timer_timeout():
	var new_agent = agent_scene.instance()
	new_agent.global_position = $Exit.global_position + Vector2(rand_range(-300,300),rand_range(-300,300))
	add_child(new_agent)
	pass # Replace with function body.
