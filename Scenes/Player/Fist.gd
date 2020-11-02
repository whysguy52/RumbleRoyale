extends Area2D

export var damage = 10
var punch_counter = 0
var fistCollision


# Called when the node enters the scene tree for the first time.
func _ready():
	visible = false
	$Sprite.position = Vector2(0,0)
	fistCollision = $CollisionShape2D


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func punch():
	$Sprite.frame = punch_counter % 2
	if position.x < 0:
		$Sprite.flip_v = true
	else:
		$Sprite.flip_v = false
	
	fistCollision.disabled = false
	visible = true
	punch_counter += 1
	$Sprite/DisplayTime.start()

func release_punch():
	fistCollision.disabled = true
	visible = false

func _on_DisplayTime_timeout():
	fistCollision.disabled = true
	visible = false
