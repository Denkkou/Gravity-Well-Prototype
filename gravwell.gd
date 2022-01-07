extends Spatial

export (int) var speed = 5

func _process(delta):
	translate(Vector3(0, 0, speed * delta))
	
	# if reaches death plane behind cam
	# 	die
