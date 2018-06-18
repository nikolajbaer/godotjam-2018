extends Area

export (bool) var active
var anim
var target
var velocity
var was_hit
const FLY_SPEED = 5
const TURN_SPEED = 0.02
const UP = Vector3(0,1,0)
const DROP = -2

func _ready():
	was_hit = false
	anim  = $AnimationPlayer
	anim.play("flapping")
	velocity = Vector3(0,0,FLY_SPEED)

func trigger_hit():
	visible = false

func _physics_process(delta):
	if not active: return
	if target != null and not was_hit:
		var v = target.translation - translation
		velocity = velocity.linear_interpolate( v, TURN_SPEED )
		# cap vertical climb speed?
		look_at(-velocity * 5,UP)
		translation += velocity * delta
		if velocity.y < 0:
			anim.play("coasting",1)
		else:
			if not anim.current_animation == "flapping":
				anim.play("flapping",1)
	elif was_hit:
		anim.play("dead")
		velocity.y += DROP
		look_at(-velocity * 5,UP)		
		translation += velocity * delta
		if translation.y <= 0:
			queue_free()
	else:
		anim.play("flapping")
	
	
		
func hit():
	was_hit = true



func _on_Bird_body_entered(body):
	if body.name == "Player":
		body.hit()
		# Fly away?

