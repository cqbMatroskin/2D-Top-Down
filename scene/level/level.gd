extends Node

@export var end_screen_scene: PackedScene

@onready var player: Player = %Player

func _ready() -> void:
	player.health_component.died.connect(on_player_died)

func on_player_died() -> void:
	var end_screen_instance = end_screen_scene.instantiate() as EndScreen
	add_child(end_screen_instance)
