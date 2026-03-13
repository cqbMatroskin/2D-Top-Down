extends Node

@onready var timer: Timer = $Timer

@export var arena_time_manager: ArenaTimeManager
@export var pumpkin_dude_scene: PackedScene

# Минимальное время спавна противников
const MIN_SPAWN_TIME: float = 0.2
# Время спавна по умолчанию
var base_spawn_time: float
# Множитель уровня сложности
var difficulty_multiplier: float = 0.01

func _ready() -> void:
	base_spawn_time = timer.wait_time
	arena_time_manager.difficulty_increased.connect(on_difficulty_increased)

func on_difficulty_increased(difficulty_level: int) -> void:
	var new_spawn_time: float = max(MIN_SPAWN_TIME, (base_spawn_time - (difficulty_level * difficulty_multiplier)))
	timer.wait_time = new_spawn_time

func get_spawn_position() -> Vector2:
	var player: Node2D = get_tree().get_first_node_in_group("player") as Node2D
	var spawn_position: Vector2
	var random_direction: Vector2 = Vector2.RIGHT.rotated(randf_range(0, TAU))
	var random_distance: int = randi_range(380, 500)
	
	for i in 24:
		spawn_position = player.global_position + (random_direction * random_distance)
		# Луч
		var raycast: PhysicsRayQueryParameters2D = PhysicsRayQueryParameters2D.create(player.global_position, spawn_position, 1)
		# Проверяем есть ли между игроком и мобом препятствия
		var intersection: Dictionary = get_tree().root.world_2d.direct_space_state.intersect_ray(raycast)
		if intersection.is_empty():
			break
		else:
			# В случае если есть пересечение, то поворачиваем лучш на 15 градусов
			random_direction = random_direction.rotated(deg_to_rad(15))
	
	return spawn_position

func _on_timer_timeout() -> void:
	var player: Node2D = get_tree().get_first_node_in_group("player") as Node2D
	if player == null:
		return
	
	var enemy: Node2D = pumpkin_dude_scene.instantiate() as Node2D
	var back_layer: Node2D = get_tree().get_first_node_in_group("back_layer") as Node2D
	back_layer.add_child(enemy)
	enemy.global_position = get_spawn_position()
