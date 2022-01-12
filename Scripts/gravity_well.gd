extends Area

export(float) var speed = 5
export(float) var max_pull_reach = 4

var can_move = false

func _ready():
	GameEvents.connect("player_position", self, "_distance_to_player")
	

func _process(delta):
	if can_move:
		self.global_translate(Vector3(0, 0, speed * delta))


# to be controlled externally
func enable_move():
	can_move = true


func disable_move():
	can_move = false


func _distance_to_player(player_pos):
	# gravity wells are now listening for player's position
	var vect_to_player = player_pos - get_global_transform().origin
	var dist_to_player = vect_to_player.length()
	
	# if within circle of influence, pull
	if dist_to_player <= max_pull_reach:
		# using grav formula, values tweaked to emulate behaviour rather than realism
		# attraction = custom gravity constant * (player mass * well mass) / distance^2
		var pull_force = 0.001 * ((1 * 1000) / (dist_to_player * dist_to_player))
		print(self.name, " is pulling with force ", pull_force)
		
		# emit signal giving player the vector to well (inverse of vect_to_player)
		GameEvents.emit_signal("gravity_exerted", -vect_to_player, pull_force)
	
	# this raycast visualises the vect_to_player, isn't used programatically
	if dist_to_player <= max_pull_reach:
		var raycast = self.get_child(2)
		raycast.cast_to = vect_to_player
