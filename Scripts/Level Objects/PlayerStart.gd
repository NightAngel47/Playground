class_name PlayerStart
extends Node2D

var player = preload("res://Scenes/player.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	_spawn_player()

## Spawns player at player start location in level
func _spawn_player():
	var spawned_player = player.instantiate()
	spawned_player.position = global_position
	spawned_player.player_died.connect(_spawn_player)
	get_tree().root.add_child.call_deferred(spawned_player)
