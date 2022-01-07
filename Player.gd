extends KinematicBody

export(float) var speed = 8
export(float) var acceleration = 50
export(float) var friction = acceleration / speed
export(float) var drag = 0.15

var _velocity = Vector3.ZERO
var _move_vector = Vector3.ZERO


func _process(delta):
	apply_movement(delta)
	apply_friction(delta)


func _physics_process(delta):
	_velocity.z += drag # illusion of flying forward
	_velocity = move_and_slide(_velocity, Vector3.UP)
	#print(_velocity)
	print(_move_vector)


# apply the _move_vector to the _velocity
func apply_movement(delta) -> void:
	_velocity += _move_vector * acceleration * delta


# slow down player 
func apply_friction(delta) -> void:
	_velocity -= _velocity * friction * delta


# signal received from touch controls
func _drag_vector(vector):
	# convert to 0 - 1 range (/ by same value as max_length :^O)
	_move_vector.x = vector.x / 300
	_move_vector.z = vector.y / 300
	
	# add some resistence to drag when moving
	if _move_vector.z < 0:
		_move_vector.z -= drag
