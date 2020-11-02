extends Area2D


var hpBox


# Called when the node enters the scene tree for the first time.
func _ready():
	hpBox = get_parent().get_node("CanvasLayer/HUD/VBoxContainer/HealthBar")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_HitBox_area_entered(body):
	
	if body.get_name() == "Fist":
		hpBox.value -= body.damage
