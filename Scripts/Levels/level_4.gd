extends Level



func _ready() -> void:
	num_level = 4

func _on_door_level_complete() -> void:
	finish_level()
