extends Label


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


func _on_JoinBtn_clicked(event):
	if event.is_action_pressed("LMB"):
		NetworkManager.myPlayerInfo["userName"] = get_parent().get_node("NameEntry").text
		NetworkManager.connect_to_server()
		get_tree().change_scene("res://Scenes/Menu/Lobby/Lobby.tscn")
