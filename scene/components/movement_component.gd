extends Node
class_name MovementComponent

## Максимальная скорость движения моба (юнитов в секунду)
@export var max_speed: int = 50
## Коэффициент ускорения.
## Чем больше значение — тем быстрее моб достигает Max Speed
@export var acceleration: float = 5

var current_velocity = Vector2.ZERO

func move_to_player(mob: CharacterBody2D) -> void:
	var direction: Vector2 = get_direction()
	var velocity: Vector2 = accelerate_to_direction(direction)
	mob.velocity = velocity
	mob.move_and_slide()

func get_direction() -> Vector2:
	var mob: Node = owner as Node2D
	var player: Node = get_tree().get_first_node_in_group("player") as Node2D
	if player == null:
		return Vector2.ZERO
	return (player.global_position - mob.global_position).normalized()

func accelerate_to_direction(direction: Vector2) -> Vector2:
	var final_velocity: Vector2 = max_speed * direction
	current_velocity = current_velocity.lerp(final_velocity, 1 - exp(-acceleration * get_process_delta_time()))
	return current_velocity
