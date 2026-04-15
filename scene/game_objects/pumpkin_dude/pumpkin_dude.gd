extends CharacterBody2D

const MAX_SPEED = 80
@onready var health_component: HealthComponent = $HealthComponent
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

func _ready() -> void:
	health_component.died.connect(on_died)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var direction: Vector2 = get_direction_to_player()
	velocity = MAX_SPEED * direction
	move_and_slide()
	
	if direction.x !=  0 || direction.y != 0:
		animated_sprite_2d.play("run")
	else:
		animated_sprite_2d.play("idle")
		
	var face_sign = sign(direction.x)
	if face_sign != 0:
		animated_sprite_2d.scale.x = face_sign

func get_direction_to_player() -> Vector2:
	var player: Node = get_tree().get_first_node_in_group("player") as Node2D
	if player == null:
		return Vector2.ZERO
	return (player.global_position - self.global_position).normalized()

func on_died() -> void:
	queue_free()
