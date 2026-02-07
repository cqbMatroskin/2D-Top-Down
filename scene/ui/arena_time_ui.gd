extends CanvasLayer

@export var arena_time_manager: Node
@onready var label: Label = %Label

func _process(delta: float) -> void:
	if arena_time_manager == null:
		return
	var time_elapsed: Variant = arena_time_manager.get_time_elapsed()
	label.text = format_timer(time_elapsed)

func format_timer(seconds: float) -> String:
	var minutes: int = floori(seconds / 60)
	var remaning_seconds: float = seconds - (minutes * 60)
	return str(minutes) + ":" + "%02d" % floori(remaning_seconds)
