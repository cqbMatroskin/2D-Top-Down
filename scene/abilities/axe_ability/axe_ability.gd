extends Node2D
class_name AxeAbility

@onready var hit_box_component: HitBoxComponent = $HitBoxComponent

const MAX_AXE_RADIUS = 100
var base_direction = Vector2.RIGHT

func _ready() -> void:
	base_direction = base_direction.rotated(randf_range(0, TAU))
	var tween: Tween = create_tween()
	tween.tween_method(rotation_animation, 0.0, 2.0, 3)
	tween.tween_callback(queue_free)

func rotation_animation(rotations: float) -> void:
	var percent: float = rotations / 2
	var axe_current_radius: float = percent * MAX_AXE_RADIUS
	var axe_current_direction: Vector2 = base_direction.rotated(rotations * TAU)
	var player: Node = get_tree().get_first_node_in_group("player") as Node2D
	
	if player == null:
		return
	
	global_position = player.global_position + (axe_current_direction * axe_current_radius)
