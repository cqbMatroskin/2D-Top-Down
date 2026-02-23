extends Node

class_name HealthComponent

signal died
signal health_changed

@export var max_health: float = 10
var current_health: float

func _ready() -> void:
	current_health = max_health

func take_damage(dmg: int) -> void:
	# При получении урона здоровье не опустится ниже нуля
	current_health = max(current_health - dmg, 0)
	health_changed.emit()
	Callable(check_death).call_deferred()

func get_health_value() -> float:
	return current_health / max_health
	
func check_death() -> void:
	if current_health == 0:
		died.emit()
