extends Node

@export var pumpkin_dude_scene: PackedScene


func _on_timer_timeout() -> void:
	var player: Node2D = get_tree().get_first_node_in_group("player") as Node2D
	if player == null:
		return
	
	var random_direction: Vector2 = Vector2.RIGHT.rotated(randf_range(0, TAU))
	var random_distance: int = randi_range(380, 500)
	var spawn_position: Vector2 = player.global_position + (random_direction * random_distance)
	
	var enemy: Node2D = pumpkin_dude_scene.instantiate() as Node2D
	var back_layer: Node2D = get_tree().get_first_node_in_group("back_layer") as Node2D
	back_layer.add_child(enemy)
	enemy.global_position = spawn_position
