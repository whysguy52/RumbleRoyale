extends Camera2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	


# Called every frame. 'delta' is the elapsed time since the previous frame.s
func _process(delta):
	pass

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_WHEEL_UP:
			zoom /= 1.1
		if event.button_index == BUTTON_WHEEL_DOWN:
			zoom *= 1.1
	zoom.x = clamp(zoom.x, 0.5, 2)
	zoom.y = clamp(zoom.y, 0.5, 2)
