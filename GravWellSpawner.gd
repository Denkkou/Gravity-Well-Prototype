extends Spatial

# get reference to waiting room which holds all of the wells to spawn
export(NodePath) onready var _gravity_well_wr = get_node(_gravity_well_wr) as Spatial

export(int) var _spawn_cap = 9
export(int) var _time_interval_min = 60
export(int) var _time_interval_max = 90

var _frames_since_last_spawn = 0
var _decided_spawn_interval = 0
var _currently_spawned = 0
var _spawn_index = 0

var _rng = RandomNumberGenerator.new()
var _rand
var _last_rand

var _waiting_room


func _ready():
	_rng.randomize()
	_waiting_room = _gravity_well_wr.get_children()


func _process(delta):
	_frames_since_last_spawn += 1
	#print(_frames_since_last_spawn)
	_spawn_well(_time_to_spawn())
	print(_currently_spawned)


func _time_to_spawn() -> bool:
	# if its time to consider spawning, and an interval isnt decided
	if _frames_since_last_spawn >= _time_interval_min:
		# decide upon a spawn interval
		if _decided_spawn_interval == 0:
			_decided_spawn_interval = _rng.randi_range(_time_interval_min, _time_interval_max)
			#print(_decided_spawn_interval)
	
	#if that interval is reached, allow spawning
	if _frames_since_last_spawn == _decided_spawn_interval:
		return true
	else:
		return false


# Add a random chance to spawn an additional well 2 spaces away
func _spawn_well(can_spawn) -> void:
	if can_spawn == true:
		# if spawned objects < spawn_cap
		if _currently_spawned < _spawn_cap:
			# randomly choose spawn point
			
			# get child at position (currently_spawned)
			var gravity_well_to_spawn = _waiting_room[_spawn_index]
			
			# spawn child(currently_spawned) at spawn point
			var spawns = self.get_children()
			
			while _rand == _last_rand:
				_rand = _rng.randi_range(0, self.get_child_count() - 1)
				
			var chosen_spawn = spawns[_rand]
			_last_rand = _rand
			
			gravity_well_to_spawn.global_transform = chosen_spawn.global_transform
			gravity_well_to_spawn.enable_move()
			
			# spawn index tracks progress through waiting room
			if _spawn_index == _spawn_cap:
				_spawn_index = 0
			
		# reset and move on
		_frames_since_last_spawn = 0
		_decided_spawn_interval = 0
		_currently_spawned += 1
		_spawn_index += 1


# if gravity well reaches destruction plane
func _on_BoundaryPlane_area_entered(area):
	if area.name.begins_with("Grav"):
		area.disable_move()
		area.global_transform = _gravity_well_wr.global_transform
		_currently_spawned -= 1
