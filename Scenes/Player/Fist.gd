extends Area2D

export var damage = 10
var punchCounter = 0
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
	$Sprite.frame = punchCounter % 2
	if position.x < 0:
		$Sprite.flip_v = true
	else:
		$Sprite.flip_v = false
	
	fistCollision.disabled = false
	visible = true
	rpc("punch_update",position, rotation_degrees, $Sprite.flip_v, visible, $Sprite.frame)
	
	punchCounter += 1
	$Sprite/DisplayTime.start()
	
	

puppet func punch_update(position: Vector2, rotation_degrees, flip_v: bool, visible: bool, fistFrame):
	$Sprite.frame = fistFrame
	$Sprite.flip_v = flip_v
	$Sprite/DisplayTime.start()
	
	self.position = position
	self.rotation_degrees = rotation_degrees
	self.visible = visible
	

func release_punch():
	remote_release_punch()
	rpc("remote_release_punch")

puppet func remote_release_punch():
	fistCollision.disabled = true
	visible = false

func _on_DisplayTime_timeout():
	fistCollision.disabled = true
	visible = false
