extends RigidBody2D


export var speed = 500

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _input(event):
	if event.is_action_pressed("ui_accept"):
		linear_velocity = Vector2.ZERO

func _physics_process(delta):
	linear_velocity.x += delta * speed * (int(Input.is_action_pressed("ui_right") )- int(Input.is_action_pressed("ui_left") ) )
	linear_velocity.y += delta * speed * (int(Input.is_action_pressed("ui_down") )- int(Input.is_action_pressed("ui_up") ) )
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
