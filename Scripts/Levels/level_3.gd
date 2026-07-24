extends Level


func _ready() -> void:
	num_level = 3

func _on_door_level_complete() -> void:
	finish_level()
