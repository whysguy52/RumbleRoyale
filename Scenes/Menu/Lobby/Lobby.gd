extends Control

var playerList: Node
var playerLabel = preload("res://Scenes/Menu/CustomMenuParts/CustomBtn.tscn")


# Called when the node enters the scene tree for the first time.
func _ready():
	playerList = $PlayerLabelContainer/PlayerList
	NetworkManager.connect("player_added_to_list", self, "_update_playerList")
	if get_tree().get_network_unique_id() != 1:
		$PlayBtn.visible = true
	_update_playerList()

func _update_playerList():
	for n in playerList.get_children():
		playerList.remove_child(n)
		n.queue_free()
	
	for key in NetworkManager.playerList:
		var player = NetworkManager.playerList[key]
		var newPlayer = playerLabel.instance()
		
		newPlayer.text = player["userName"]
		playerList.add_child(newPlayer)
		
	

func _on_PlayBtn_clicked(event):
	if event.is_action_pressed("LMB"):
		NetworkManager.begin_game()
