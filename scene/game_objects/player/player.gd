extends CharacterBody2D
class_name Player

@onready var health_component: HealthComponent = $HealthComponent
@onready var grace_period: Timer = $GracePeriod
@onready var progress_bar: ProgressBar = $ProgressBar

const MAX_SPEED: int = 125
const ACCELERATION: float = 0.1
var enemies_colliding: int = 0

func _ready() -> void:
	health_component.died.connect(on_died)
	health_component.health_changed.connect(on_health_changed)
	health_update()

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

func health_update() -> void:
	progress_bar.value = health_component.get_health_value()


func check_if_damaged() -> void:
	if enemies_colliding == 0 || !grace_period.is_stopped():
		return
	health_component.take_damage(1)
	grace_period.start()

func on_died() -> void:
	queue_free()

func on_health_changed() -> void:
	health_update()

func _on_player_hurt_box_area_entered(area: Area2D) -> void:
	enemies_colliding += 1
	check_if_damaged()

func _on_player_hurt_box_area_exited(area: Area2D) -> void:
	enemies_colliding -= 1


func _on_grace_period_timeout() -> void:
	check_if_damaged()
