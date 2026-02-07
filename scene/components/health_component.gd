extends Node

class_name HealthComponent

signal died

@export var max_health: int = 10
var current_health: int

func _ready() -> void:
	current_health = max_health

func take_damage(dmg: int) -> void:
	# При получении урона здоровье не опустится ниже нуля
	current_health = max(current_health - dmg, 0)
	Callable(check_death).call_deferred()
	
func check_death() -> void:
	if current_health == 0:
		died.emit()
		owner.queue_free()
