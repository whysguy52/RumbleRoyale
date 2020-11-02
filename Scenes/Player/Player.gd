extends KinematicBody2D


export var speed = 600
export var isPlayer = true

var velocity = Vector2()
var Stamina 

# Called when the node enters the scene tree for the first time.
func _ready():
	Stamina = $CanvasLayer/HUD/VBoxContainer/StaminaBar

func _process(delta):
	if not is_network_master():
		return
	process_input()

func process_input():
	
	#Movement
	velocity.x = int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left"))
	velocity.y = int(Input.is_action_pressed("ui_down")) - int(Input.is_action_pressed("ui_up"))
	velocity = velocity.normalized()
	calculate_stamina()
	velocity *= speed
	move_and_slide(velocity)
	run_animation()
	
	#Punching
	if Input.is_action_just_pressed("LMB"):
		$Fist.position = get_local_mouse_position().normalized() * 75
		$Fist.rotation_degrees = rad2deg($Fist.position.angle())
		$Fist.punch()
	if Input.is_action_just_released("LMB"):
		$Fist.release_punch()



func run_animation():
	
	if velocity.x < 0 and velocity.length() != 0 :
		$AnimatedSprite.flip_h = true
	if velocity.x > 0 and velocity.length() != 0 :
		$AnimatedSprite.flip_h = false
	
	if velocity.length() != 0:
		$AnimatedSprite.play("Run")
	else:
		$AnimatedSprite.stop()
		$AnimatedSprite.frame = 0

func calculate_stamina():
	if Input.is_action_pressed("ui_LShift"):
		if Stamina.value > 10:
			$AnimatedSprite.speed_scale = 1.5
			speed = 1200
		else:
			$AnimatedSprite.speed_scale = 1
			speed = 600
		Stamina.value -= 2
	else:
		$AnimatedSprite.speed_scale = 1
		speed = 600
	Stamina.value += 1

func set_camera():
	$Camera2D.make_current()
	$CanvasLayer/HUD.visible = true
