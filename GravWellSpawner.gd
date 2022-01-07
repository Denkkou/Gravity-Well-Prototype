extends Spatial


# if gravity well reaches destruction plane
	# the plane should emit a signal containing info on the well that touched it
	# this object should receive that signal, and teleport that well into waiting and -1 from total
	# disable the well's movement via its disable_move function


# get reference to waiting room which holds all of the wells to spawn
export(NodePath) onready var _gravity_well_wr = get_node(_gravity_well_wr) as Spatial

export(int) var _spawn_cap = 5
export(int) var _time_interval_min = 120
export(int) var _time_interval_max = 200

var _frames_since_last_spawn = 0
var _decided_spawn_interval = 0
var _currently_spawned = 0

var _rng = RandomNumberGenerator.new()
var _waiting_room

func _ready():
	_rng.randomize()
	_waiting_room = _gravity_well_wr.get_children()


func _process(delta):
	_frames_since_last_spawn += 1
	print(_frames_since_last_spawn)
	_spawn_well(_time_to_spawn())


func _time_to_spawn() -> bool:
	# if its time to consider spawning, and an interval isnt decided
	if _frames_since_last_spawn >= _time_interval_min:
		# decide upon a spawn interval
		if _decided_spawn_interval == 0:
			_decided_spawn_interval = _rng.randi_range(_time_interval_min, _time_interval_max)
			print(_decided_spawn_interval)
	
	#if that interval is reached, allow spawning
	if _frames_since_last_spawn == _decided_spawn_interval:
		return true
	else:
		return false


func _spawn_well(can_spawn) -> void:
	if can_spawn == true:
		# if spawned objects < spawn_cap
		if _currently_spawned < _spawn_cap:
			# randomly choose spawn point
			
			# get child at position (currently_spawned)
			var gravity_well_to_spawn = _waiting_room[_currently_spawned]
			
			# spawn child(currently_spawned) at spawn point
			gravity_well_to_spawn.global_transform = self.global_transform
			gravity_well_to_spawn.enable_move()
			
		# reset and move on
		_frames_since_last_spawn = 0
		_decided_spawn_interval = 0
		_currently_spawned += 1
