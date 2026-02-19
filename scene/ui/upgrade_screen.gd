extends CanvasLayer
class_name UpgradeScreen

@export var upgrade_card_screen: PackedScene

@onready var card_container: HBoxContainer = $MarginContainer/CardContainer

func _ready() -> void:
	get_tree().paused = true

func set_ability_upgrades(upgrades: Array[AbilityUpgrade]) -> void:
	for upgrade in upgrades:
		var upgrade_card_instance = upgrade_card_screen.instantiate() as AbilityUpgradeCard
		card_container.add_child(upgrade_card_instance)
		upgrade_card_instance.set_ability_upgrade(upgrade)
