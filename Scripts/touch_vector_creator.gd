extends Area2D
# https://www.youtube.com/watch?v=jj5zpkAlPkE

signal vector_created(vector)

export(float) var max_length := 150

var touch_down := false
var position_start := Vector2.ZERO
var position_end := Vector2.ZERO

var vector := Vector2.ZERO


func _ready():
	connect("input_event", self, "_on_input_event")


# draw the lines on screen
func _draw() -> void:
	draw_line(position_start - global_position,
		(position_end - global_position),
		Color.blue,
		8)
	
	draw_line(position_start - global_position,
		position_start - global_position + vector,
		Color.red,
		16)


func _reset() -> void:
	position_start = Vector2.ZERO
	position_end = Vector2.ZERO
	vector = Vector2.ZERO
	
	update()


func _input(event) -> void:
	if not touch_down:
		return
	
	if event.is_action_released("ui_touch"):
		touch_down = false
		_reset()
	
	if event is InputEventMouseMotion:
		position_end = event.position
		vector = (position_end - position_start).clamped(max_length)
		update()
	
	emit_signal("vector_created", vector)


func _on_input_event(_viewport, event, _shape_idx) -> void:
	if event.is_action_pressed("ui_touch"):
		touch_down = true
		position_start = event.position
