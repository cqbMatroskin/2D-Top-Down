extends Node

@export var experience_manager: ExpManager
@export var upgrade_poll: Array[AbilityUpgrade]

var current_upgrades: Dictionary = {}

func _ready() -> void:
	experience_manager.level_up.connect(on_lvl_up)

func on_lvl_up(current_level: int) -> void:
	# Случайный апгрейд
	var choosen_upgrade: AbilityUpgrade = upgrade_poll.pick_random() as AbilityUpgrade
	if choosen_upgrade == null:
		return
	var has_upgrade: bool = current_upgrades.has(choosen_upgrade.id)
	if !has_upgrade:
		current_upgrades[choosen_upgrade.id] = {
			"upgrade": choosen_upgrade,
			"quantity": 1
		}
	else:
		current_upgrades[choosen_upgrade.id]["quantity"] += 1
	print(current_upgrades)
