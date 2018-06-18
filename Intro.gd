extends Spatial

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	#$Player/Flamethrower.emitting = true
	$Player/Flamethrower.rotation.y = deg2rad(-90)
	$Player/Flamethrower.rotation.x = deg2rad(-15)

	
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func _process(delta):
	if Input.is_action_pressed("fire"):
		get_tree().change_scene("res://root.tscn")
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass


func _on_Timer_timeout():
	if $Player/Flamethrower.emitting:
		$Player/Flamethrower.emitting = false
		$Timer.wait_time = 5
		$Timer.start()
	else:
		$Player/Flamethrower.emitting = true
		$Timer.wait_time = 1
		$Timer.start()
	