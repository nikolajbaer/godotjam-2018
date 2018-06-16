extends Area

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var num
signal gate_hit(n)

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func _on_Gate_body_entered(body):
	self.visible = false
	emit_signal("gate_hit",num+1)
