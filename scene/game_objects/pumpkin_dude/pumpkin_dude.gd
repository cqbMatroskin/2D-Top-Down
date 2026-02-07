extends CharacterBody2D

const MAX_SPEED = 80
@onready var health_component: HealthComponent = $HealthComponent

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var direction: Vector2 = get_direction_to_player()
	velocity = MAX_SPEED * direction
	move_and_slide()

func get_direction_to_player() -> Vector2:
	var player: Node = get_tree().get_first_node_in_group("player") as Node2D
	if player == null:
		return Vector2.ZERO
	return (player.global_position - self.global_position).normalized()
	
