extends CanvasLayer
class_name EndScreen

@onready var name_label: Label = %NameLabel

func _ready() -> void:
	get_tree().paused = true
	
func change_to_victory() -> void:
	name_label.text = "Победа!"

func _on_restart_btn_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scene/level/level.tscn")

func _on_quit_btn_pressed() -> void:
	get_tree().quit()
