extends Label


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass




func _on_CreateLobbyBtn_clicked(event):
	if event.is_action_pressed("LMB"):
		NetworkManager.myPlayerInfo["userName"] = get_parent().get_node("NameEntry").text
		NetworkManager.create_server()
		get_tree().change_scene("res://Scenes/Menu/Lobby/Lobby.tscn")
