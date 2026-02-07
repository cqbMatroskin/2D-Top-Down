extends Node

var current_exp: int = 0

func _ready() -> void:
	Global.exp_bottle_collected.connect(on_exp_bottle_collected)

func on_exp_bottle_collected(experience: int) -> void:
	current_exp += experience
	print(current_exp)
