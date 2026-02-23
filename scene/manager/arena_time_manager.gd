extends Node
class_name ArenaTimeManager

signal difficulty_increased(difficulty_level: int)

@export var end_screen_scene: PackedScene

@onready var timer = $Timer

var difficulty_level: int = 0

func get_time_elapsed() -> float:
	return timer.wait_time - timer.time_left


func _on_timer_timeout() -> void:
	var end_screen_instance: Node = end_screen_scene.instantiate() as EndScreen
	get_parent().add_child(end_screen_instance)
	end_screen_instance.change_to_victory()


func _on_difficulty_timer_timeout() -> void:
	difficulty_level += 1
	difficulty_increased.emit(difficulty_level)
