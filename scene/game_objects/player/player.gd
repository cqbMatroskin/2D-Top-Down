extends CharacterBody2D

const MAX_SPEED: int = 125
const ACCELERATION: float = 0.1


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var direction: Vector2 = movement_vector().normalized()
	var target_velocity = MAX_SPEED * direction
	velocity = velocity.lerp(target_velocity, ACCELERATION)

	move_and_slide()

func movement_vector() -> Vector2:
	var movement_x: float = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	var movement_y: float = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	return Vector2(movement_x, movement_y)
