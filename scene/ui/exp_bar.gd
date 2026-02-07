extends CanvasLayer

@export var exp_manager: ExpManager
@onready var progress_bar: ProgressBar = $MarginContainer/ProgressBar

func _ready() -> void:
	progress_bar.value = 0
	exp_manager.exp_update.connect(on_exp_updated)

func on_exp_updated(current_exp: float, target_exp: float) -> void:
	var current_value: float = current_exp / target_exp
	progress_bar.value = current_value
