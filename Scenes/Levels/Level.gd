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


func _on_Area2D2_body_entered(body):
	pass # Replace with function body.


func _on_Rock_Area2D_body_entered():
	pass # Replace with function body.


func _on_RockArea_body_entered(body):
	if body.get_name().to_int() == get_tree().get_network_unique_id():
		$RockLevel.play()


func _on_RockArea_body_exited(body):
	if body.get_tree().get_network_unique_id() == get_tree().get_network_unique_id():
		$RockLevel.stop()


func _on_CityArea_body_entered(body):
	if body.get_name().to_int() == get_tree().get_network_unique_id():
		$CityAudio.play()


func _on_CityArea_body_exited(body):
	if body.get_name().to_int() == get_tree().get_network_unique_id():
		$CityAudio.stop()
