extends Node

@export var exp_bottle_scene: PackedScene
@export var health_component: Node
@export var drop_percent: float = .5

func _ready() -> void:
	(health_component as HealthComponent).died.connect(on_died)

func on_died() -> void:
	# 50% шанс спавна бутылька
	if randf() < drop_percent:
		return
	if exp_bottle_scene == null || not owner is Node2D:
		return
	var spawn_pos: Vector2 = (owner as Node2D).global_position
	var exp_bottle_instance: Node = exp_bottle_scene.instantiate() as Node2D
	var back_layer: Node2D = get_tree().get_first_node_in_group("back_layer") as Node2D
	back_layer.add_child(exp_bottle_instance)
	exp_bottle_instance.global_position = spawn_pos
