extends Area

export(float) var speed = 8

var can_move = false

func _process(delta):
	if can_move:
		self.global_translate(Vector3(0, 0, speed * delta))


# to be controlled externally
func enable_move():
	can_move = true

func disable_move():
	can_move = false
