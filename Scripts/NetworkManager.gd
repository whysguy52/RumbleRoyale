extends Node

const PORT = 19283

var playerList : Dictionary = {}
var myPlayerInfo = {"userName": ""} #when i get more characters, add collumn with the characters name

signal player_added_to_list

# Called when the node enters the scene tree for the first time.
func _ready():
	get_tree().connect("network_peer_connected", self, "_player_connected")

#
#	SERVER CODE
#

#called from PreLobbyMenu when "CreateLobby" is clicked
func create_server():
	var peer = NetworkedMultiplayerENet.new()
	peer.create_server(PORT, 3)
	get_tree().network_peer = peer
	add_player_to_list(1, myPlayerInfo)

func begin_game():
	rpc("start_game")
	start_game()
#
#	CLIENT CODE
#

#called from the "Join" button
func connect_to_server():
	var peer = NetworkedMultiplayerENet.new()
	peer.create_client("127.0.0.1", PORT)
	get_tree().network_peer = peer
	add_player_to_list(get_tree().get_network_unique_id(), myPlayerInfo)

#
#	BOTH CODE
#

#this signal handler is called on all clients and server when a new player connects
func _player_connected(id):
	rpc_id(id, "register_player", myPlayerInfo)


remote func register_player(info):
	var id = get_tree().get_rpc_sender_id()
	add_player_to_list(id, info)
	

func add_player_to_list(id, info):
	playerList[id] = info
	emit_signal("player_added_to_list")
	print_debug(playerList)

remote func start_game():
	
	#Manually change scenes since change_scene() is an asychronous call
	#remove current scene
	var level = get_tree().get_root().get_node("Lobby")
	get_tree().get_root().remove_child(level)
	level.call_deferred("free")
	
	#add level scene
	var level_scene = load("res://Scenes/Levels/TestLevel.tscn")
	var next_level = level_scene.instance()
	get_tree().get_root().add_child(next_level)
	
	var player_scene = load("res://Scenes/Player/Player.tscn")
	
	for p_id in playerList:
		var player = player_scene.instance()
		player.set_name(str(p_id))
		player.set_network_master(p_id)
		
		get_tree().get_root().get_node("Level").add_child(player)
		
		if p_id == get_tree().get_network_unique_id():
			player.set_camera()
	
