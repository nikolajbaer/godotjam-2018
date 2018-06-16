extends KinematicBody

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var fire
var lift
const LIFT = 0.1
const MAX_LIFT = 10
const MAX_DESCEND = -10
const WIND_MAG = 5
const CLINE_SZ = 7
var wind_stack
var flag
var thrower 

func _ready():
	fire = $Fire
	lift = 0
	flag = $FlagPivot
	thrower = $Flamethrower
	
	# different wind at each altitude
	wind_stack = []
	for i in range(50):
		wind_stack.append(Vector2(0.5-randf(),0.5-randf()) * (randf() * WIND_MAG ) )
	
func _physics_process(delta):

	var m = get_viewport().get_mouse_position()
	var x = 0.5 - (m.x / get_viewport().size.x)
	thrower.rotation.y = deg2rad(x*360)
	thrower.emitting = Input.is_action_pressed("fire")
		
	
	if Input.is_action_pressed("up"):
		lift += LIFT * delta
		if lift > MAX_LIFT:
			lift = MAX_LIFT 
		fire.light_energy = 16
	else:
		fire.light_energy = 0
		
	if Input.is_action_pressed("hole"):
		lift -= LIFT * delta
		if lift < MAX_DESCEND:
			lift = MAX_DESCEND
		# Clip Sphere?
	else:
		# Unclip Sphere?
		pass
	
	var v = Vector3(0,lift,0)
	
	# Apply wind based on altitude
	var wind = wind_stack[floor(translation.y / CLINE_SZ)] * delta
	var wind_dir = Vector3(wind.x,0,wind.y).angle_to(Vector3(1,0,0))
	flag.rotation.y = wind_dir
	v += Vector3(wind.x,0,wind.y)
	
	# maybe reposition camera on altitude?
	
	var c = move_and_collide(v)
	if c != null:
		lift = 0
	
