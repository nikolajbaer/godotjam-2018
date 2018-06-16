extends Spatial

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	var tree_scene =  load("res://Tree.tscn")
	for i in range(500):
		var t = tree_scene.instance()
		t.translation = Vector3(250-randf()*500,0,250-randf()*500)
		t.scale *= randf() * 0.25 + 1
		add_child(t)

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
