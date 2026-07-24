extends Level


func _ready() -> void:
	num_level = 2

func _on_door_level_complete() -> void:
	finish_level()
