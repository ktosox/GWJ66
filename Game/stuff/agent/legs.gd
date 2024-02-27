extends PathFollow2D

export var moving = false

export var stamina = 60

var max_stamina = 60

export var speed = 30


var walking_just_started = true

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
	offset = 0
	walking_just_started = true
	$MinWalkTime.start()
	speed = stamina * urgency
	moving = true
	set_physics_process(true)
	pass

func stop_walking():
	
	moving = false
	set_physics_process(false)
	pass


func _physics_process(delta):
	var endurance = 0.03
	if moving:
		
		offset += delta * speed

		var stamina_loss = delta * pow(speed,1.2) * endurance
		speed = speed - speed * (stamina_loss / max_stamina)
		stamina -= stamina_loss

		

	stamina = min(max_stamina, stamina + delta * 20)
	
	if unit_offset == 1.0 and !walking_just_started:
		emit_signal("goal_reached")
		stop_walking()
		

#	if $Torso.position.distance_to($Legs.position) > 25 :
#		tumble()
#		move_to_point(to_global(curve.get_point_position(curve.get_point_count()-1)) )


func _on_MinWalkTime_timeout():
	walking_just_started = false
	pass # Replace with function body.
