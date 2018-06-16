extends Spatial

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
const UP = Vector3(0,1,0)

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
func point_at(pos):
	look_at(pos,UP)