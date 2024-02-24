extends PathFollow2D

export var moving = false

export var stamina = 60

var max_stamina = 60

export var speed = 30


export var torso_goes_here : NodePath

signal goal_reached

func _ready():
	
	assert(torso_goes_here != null)
	
	$Pelvis.node_b = "../"+torso_goes_here

	

func fall():
	$Pelvis.node_a = NodePath("")
	stop_walking()

func un_fall():
	$Pelvis.set_deferred("node_a",NodePath("../Mover"))
	pass


func start_walking(urgency = 1.0):
	#assert(!moving)
	
	speed = stamina * urgency
	moving = true
	pass

func stop_walking():
	offset = 0
	moving = false
	pass


func _physics_process(delta):
	var endurance = 0.03
	if moving:
		
		offset += delta * speed

		var stamina_loss = delta * pow(speed,1.2) * endurance
		speed = speed - speed * (stamina_loss / max_stamina)
		stamina -= stamina_loss

		
	else:
		stamina = min(max_stamina, stamina + delta * 10)
	
#	if unit_offset == 1.0:
#		emit_signal("goal_reached")
#		print("goal_reached")
#		stop_walking()
		

#	if $Torso.position.distance_to($Legs.position) > 25 :
#		tumble()
#		move_to_point(to_global(curve.get_point_position(curve.get_point_count()-1)) )
