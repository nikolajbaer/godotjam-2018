extends KinematicBody

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var fire
var lift
const UP = Vector3(0,1,0)
const LIFT = 0.1
const MAX_LIFT = 10
const MAX_DESCEND = -10
const WIND_MAG = 4
const WIND_LEVEL = 15.0
const COOLING = 0.005
const CEILING = 200
var wind_stack
var flag
var thrower 
var ray
var health

func _ready():
	health = 100
	fire = $Fire
	lift = 0
	flag = $FlagPivot
	thrower = $Flamethrower
	ray = $Flamethrower/RayCast
	
func _physics_process(delta):

	var m = get_viewport().get_mouse_position()
	var x = 0.5 - (m.x / get_viewport().size.x)
	var y = 0.5 - (m.y / get_viewport().size.y)
	thrower.rotation.y = deg2rad(x*-360)
	thrower.rotation.x = deg2rad(45-y*90 - 45)
	thrower.emitting = Input.is_action_pressed("fire")
	
	if Input.is_action_pressed("up"):
		lift += LIFT * delta
		if lift > MAX_LIFT:
			lift = MAX_LIFT 
		fire.light_energy = 16
	else:
		lift -= COOLING * delta
		if lift < MAX_DESCEND:
			lift = MAX_DESCEND
		fire.light_energy = 0
		
	if Input.is_action_pressed("hole"):
		lift -= LIFT * delta
		if lift < MAX_DESCEND:
			lift = MAX_DESCEND
		# Clip Sphere?
	else:
		# Unclip Sphere?
		pass
	
	# cap the max altitude
	if translation.y > CEILING and lift > 0:
		lift = 0
	
	var v = Vector3(0,lift,0)
	
	# Apply wind based on altitude (clockwise to the right)
	var w = ( translation.y - floor(translation.y / WIND_LEVEL) * WIND_LEVEL ) / WIND_LEVEL
	var wind_angle = deg2rad( w * -360 )
	var wind_m = WIND_MAG
	if translation.y < WIND_LEVEL:
		wind_m *= clamp(log(translation.y/WIND_LEVEL)/2+1,0,1)
	var wind = Vector3(1,0,0).rotated(UP,wind_angle) * wind_m * delta
	flag.rotation.y = wind_angle
	v += wind
	
	# maybe reposition camera on altitude?

	var c = move_and_collide(v)
	if c != null:
		lift = 0


func _on_Area_area_entered(area):
	if thrower.emitting and "Bird" in area.name or "Mine" in area.name:
		area.hit()

func explode():
	pass

func hit():
	health -= 50
	if health < 0:
		get_tree().root.get_node("root").explode(translation)
		queue_free()
		# TODO show new scene!
		
		