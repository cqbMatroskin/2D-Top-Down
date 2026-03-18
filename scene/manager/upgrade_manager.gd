extends Node

@export var experience_manager: ExpManager
@export var upgrade_pool: Array[AbilityUpgrade]
@export var upgrade_screen_scene: PackedScene

var current_upgrades: Dictionary = {}

func _ready() -> void:
	experience_manager.level_up.connect(on_lvl_up)


func apply_upgrade(upgrade: AbilityUpgrade) -> void:
	var has_upgrade: bool = current_upgrades.has(upgrade.id)
	if !has_upgrade:
		current_upgrades[upgrade.id] = {
			"upgrade": upgrade,
			"quantity": 1
		}
	else:
		current_upgrades[upgrade.id]["quantity"] += 1

	Global.ability_upgrade_added.emit(upgrade, current_upgrades)


func pick_upgrades() -> Array[AbilityUpgrade]:
	var chosen_upgrades: Array[AbilityUpgrade]
	var pool_copy: Array[AbilityUpgrade] = upgrade_pool.duplicate()
	for i in 2:
		# Случайный апгрейд
		var choosen_upgrade: AbilityUpgrade = pool_copy.pick_random() as AbilityUpgrade
		chosen_upgrades.append(choosen_upgrade)
		# Исключаем из массива выбранный апгрейд чтобы он не попался на следующей итерации
		pool_copy = pool_copy.filter(func(upgrade: AbilityUpgrade): return upgrade.id != choosen_upgrade.id)
	
	return chosen_upgrades

func on_lvl_up(current_level: int) -> void:
	var upgrade_screen_instance: Node = upgrade_screen_scene.instantiate() as UpgradeScreen
	add_child(upgrade_screen_instance)
	var choosen_upgrades: Array[AbilityUpgrade] = pick_upgrades()
	upgrade_screen_instance.set_ability_upgrades(choosen_upgrades)
	upgrade_screen_instance.upgrade_selected.connect(on_upgrade_selected)

func on_upgrade_selected(upgrade: AbilityUpgrade) -> void:
	apply_upgrade(upgrade)
