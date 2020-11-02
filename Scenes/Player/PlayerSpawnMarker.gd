extends KinematicBody2D


export var speed = 600
export var isPlayer = true

var velocity = Vector2()


# Called when the node enters the scene tree for the first time.
func _ready():
	if isPlayer:
		$Camera2D.make_current()

func _process(delta):
	if !isPlayer:
		return
	process_input()

func process_input():
	
	#Movement
	velocity.x = int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left"))
	velocity.y = int(Input.is_action_pressed("ui_down")) - int(Input.is_action_pressed("ui_up"))
	velocity = velocity.normalized()
	velocity *= speed
	move_and_slide(velocity)
	
	if Input.is_action_just_pressed("LMB"):
		pass
