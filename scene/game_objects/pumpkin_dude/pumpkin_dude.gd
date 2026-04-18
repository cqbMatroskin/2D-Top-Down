extends CharacterBody2D

const MAX_SPEED = 80
@onready var health_component: HealthComponent = $HealthComponent
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var movement_component: MovementComponent = $MovementComponent

@export var death_scene: PackedScene
@export var death_sprite: CompressedTexture2D

func _ready() -> void:
	health_component.died.connect(on_died)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var direction: Vector2 = movement_component.get_direction()
	movement_component.move_to_player(self)
	
	if direction.x !=  0 || direction.y != 0:
		animated_sprite_2d.play("run")
	else:
		animated_sprite_2d.play("idle")
		
	var face_sign = sign(direction.x)
	if face_sign != 0:
		animated_sprite_2d.scale.x = face_sign


func on_died() -> void:
	var back_layer: Node = get_tree().get_first_node_in_group("back_layer")
	var death_instance = death_scene.instantiate() as DeathComp
	back_layer.add_child(death_instance)
	death_instance.gpu_particles_2d.texture = death_sprite
	death_instance.sprite_offset.position.y = animated_sprite_2d.offset.y
	death_instance.global_position = global_position
	queue_free()
