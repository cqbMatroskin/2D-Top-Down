extends Node2D

const BOTTLE_EXP: int = 1

func _on_area_2d_area_entered(area: Area2D) -> void:
	Global.exp_bottle_collected.emit(BOTTLE_EXP)
	queue_free()
