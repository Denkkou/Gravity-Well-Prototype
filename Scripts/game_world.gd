extends Spatial

var title = "Gravity Well Prototype"

func _process(delta):
	OS.set_window_title(title + " | FPS: " + str(Engine.get_frames_per_second()))
