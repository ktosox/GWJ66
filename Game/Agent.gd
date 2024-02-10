extends PathFollow2D

var speed = 20

func _physics_process(delta):
	offset += speed*delta
	pass
