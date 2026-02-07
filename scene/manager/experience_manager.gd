extends Node
class_name ExpManager

signal exp_update(current_exp: float, target_exp: float)

var current_exp: float = 0
var target_exp: float = 5
var target_after_lvlup:float = 5
var current_lvl: int = 1

func _ready() -> void:
	Global.exp_bottle_collected.connect(on_exp_bottle_collected)

func on_exp_bottle_collected(experience: int) -> void:
	current_exp = min(current_exp + experience, target_exp)
	exp_update.emit(current_exp, target_exp)
	
	if current_exp == target_exp:
		current_lvl += 1
		current_exp = 0
		target_exp += target_after_lvlup
		exp_update.emit(current_exp, target_exp)
