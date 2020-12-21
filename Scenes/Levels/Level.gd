extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_Area2D_body_entered(body):
	if body.get_name().to_int() == get_tree().get_network_unique_id():
		print_debug(body.get_name(), ",", get_tree().get_network_unique_id())
		$AudioStreamPlayer.play()


func _on_Area2D_body_exited(body):
	if body.get_tree().get_network_unique_id() == get_tree().get_network_unique_id():
		$AudioStreamPlayer.stop()
