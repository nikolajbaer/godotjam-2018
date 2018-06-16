extends Spatial

# TODO
# wind clockwise change with altitude
# progressively lose lift as balloon cools
# Add mockingbirds
# Add path
# Add spike mines
# Add finish
# vertical control of 'thrower
const UP = Vector3(0,1,0)
var target
var arrow
var player

func _ready():
	var tree_scene =  load("res://Tree.tscn")
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

func _process(delta):
	if target != null:
		arrow.look_at_from_position(player.translation,target.translation,UP)

func _gate_hit(n):
	target = $Gates.get_node("Gate%s"%n)
	if target != null:
		target.visible = true
	else:
		# Win? s
		pass
