extends CanvasLayer
class_name UpgradeScreen

signal upgrade_selected(upgrade: AbilityUpgrade)

@export var upgrade_card_screen: PackedScene

@onready var card_container: HBoxContainer = $MarginContainer/CardContainer

func _ready() -> void:
	get_tree().paused = true

func set_ability_upgrades(upgrades: Array[AbilityUpgrade]) -> void:
	for upgrade in upgrades:
		var upgrade_card_instance = upgrade_card_screen.instantiate() as AbilityUpgradeCard
		card_container.add_child(upgrade_card_instance)
		upgrade_card_instance.set_ability_upgrade(upgrade)
		# bind добавляет параметр к эмиту
		upgrade_card_instance.card_selected.connect(on_upgrade_selected.bind(upgrade))

func on_upgrade_selected(upgrade: AbilityUpgrade) -> void:
	upgrade_selected.emit(upgrade)
	get_tree().paused = false
	queue_free()
