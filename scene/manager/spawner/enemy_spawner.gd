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
	print_debug(new_spawn_time)

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
