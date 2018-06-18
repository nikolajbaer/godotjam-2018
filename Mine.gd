extends Area

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func hit():
	explode()

func _on_Mine_body_entered(body):
	print("Hit %s"%body.name)
	if body.name == "Player":
		body.hit()
	explode()
	
func explode():
	var e = get_tree().root.get_node("root").explode(translation)
	queue_free()