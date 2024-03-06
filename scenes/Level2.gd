extends Node

var playerScene = preload("res://scenes/Player.tscn")
var spawnPosition = Vector2.ZERO
var currentPlayerNode = null

func _ready():
	spawnPosition = $Player.global_position
	register_player($Player)
	
	$EndLevel.connect("player_won", self, "on_player_won")
	$LoseScreen.connect("player_lose", self, "on_player_lose")

func register_player(player):
	currentPlayerNode = player
	currentPlayerNode.connect("died", self, "on_player_died", [], CONNECT_DEFERRED)

func create_player():
	var playerInstance = playerScene.instance()
	add_child_below_node(currentPlayerNode, playerInstance)
	playerInstance.global_position = spawnPosition
	register_player(playerInstance)

func on_player_died():
	currentPlayerNode.queue_free()
	create_player()

func on_player_won():
	var scene_change = get_tree().change_scene("res://scenes/WinScreen.tscn")

func on_player_lose():
	var scene_change = get_tree().change_scene("res://scenes/LoseScreen.tscn")
