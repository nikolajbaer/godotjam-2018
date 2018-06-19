extends Spatial

# TODO
# Add finish
const UP = Vector3(0,1,0)
var target
var arrow
var player
var bird_scene
var b
var explode_scene
var explosions
var retry

func _ready():
	retry = false
	b = 0
	explode_scene = load("res://Explosion.tscn")
	explosions = $Explosions
	var tree_scene =  load("res://Tree.tscn")
	bird_scene = load("res://Bird.tscn")
	for i in range(500):
		var t = tree_scene.instance()
		t.translation = Vector3(250-randf()*500,0,250-randf()*500)
		t.scale *= randf() * 0.25 + 1
		add_child(t)

	var i = 1
	for gate in $Gates.get_children():
		gate.num = i
		if gate.name != "Gate1":
			gate.visible = false
		i += 1
		gate.connect("gate_hit",self,"_gate_hit")
		
	target = $Gates/Gate1
	player = $Player
	arrow = $Arrow
	arrow.visible = true

func explode(pos):
	var e = explode_scene.instance()
	e.translation = pos
	explosions.add_child(e)
	e.emitting = true

func _process(delta):
	if retry and Input.is_action_pressed("fire"):
		get_tree().change_scene("res://Intro.tscn")
		
	if target != null:
		arrow.look_at_from_position(player.translation,target.translation,UP)
	$Control/Label.text = "Altitude: %sm" % int(player.translation.y)
	$Control/Label2.text = "Health: %s/100" % int(player.health)

func _gate_hit(n):
	target = $Gates.get_node("Gate%s"%n)
	if target != null:
		target.visible = true
		spawn_bird(50-randf()*100,randf()*50,randf()*100)
	else:
		success()

func success():
	player.active = false
	$Control/Success.visible = true
	
func failure():
	$Control/TryAgain.visible = true
	retry = true

func spawn_bird(x,y,z):
	var bird = bird_scene.instance()
	bird.name = "Bird%s"%b
	bird.active = true
	b += 1
	bird.translation = Vector3(x,y,z)
	bird.look_at(player.translation,UP)
	bird.target = player
	$Birds.add_child(bird)
	

func _on_Timer_timeout():
	$Control/Help.visible = false
