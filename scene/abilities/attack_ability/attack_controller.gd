extends Node

const ATTACK_RANGE: int = 100
const DAMAGE: int = 10

@export var attack_ability: PackedScene

func _on_timer_timeout() -> void:
	var player: Node2D = get_tree().get_first_node_in_group("player") as Node2D
	var level: Node = get_tree().get_first_node_in_group("level")
	
	if player == null || level == null:
		return
	
	var player_pos: Vector2 = player.global_position
	var enemies: Array[Node] = get_tree().get_nodes_in_group("enemy")
	
	enemies = enemies.filter(func(enemy: Node2D) -> bool:
		return enemy.global_position.distance_squared_to(player_pos) < pow(ATTACK_RANGE, 2)
	)
	
	if enemies.size() == 0:
		return
	
	enemies.sort_custom(func(a: Node2D, b: Node2D) -> bool:
		var a_distance: float = a.global_position.distance_squared_to(player_pos)
		var b_distance: float = b.global_position.distance_squared_to(player_pos)

		return a_distance < b_distance
	)
	# Ближайший враг
	var enemy_pos: Vector2 = enemies[0].global_position
	var attack_instance: Node2D = attack_ability.instantiate() as AttackAbility
	level.add_child(attack_instance)
	
	attack_instance.hit_box_component.damage = DAMAGE
	attack_instance.global_position = (enemy_pos + player_pos) / 2
	# Повернуть меч в сторону врага
	attack_instance.look_at(enemy_pos)
