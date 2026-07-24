extends CanvasLayer


@onready var actual_level = get_node(get_parent().get_path())


func _ready() -> void:
	$PanelContainer/VBoxContainer/HBoxContainer/TextureRect.visible = false
	$PanelContainer/VBoxContainer/HBoxContainer/TextureRect2.visible = false
	$PanelContainer/VBoxContainer/HBoxContainer/TextureRect3.visible = false
	get_tree().paused = true

func visibleCoins(coins):
	if coins >= 1:
		$PanelContainer/VBoxContainer/HBoxContainer/TextureRect.visible = true
	if coins >= 2:
		$PanelContainer/VBoxContainer/HBoxContainer/TextureRect2.visible = true
	if coins >= 3:
		$PanelContainer/VBoxContainer/HBoxContainer/TextureRect3.visible = true

func _on_levels_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Scenes/levels.tscn")

func _on_reset_pressed() -> void:
	get_tree().paused = false
	if actual_level.num_level == 1:
		get_tree().change_scene_to_file("res://Scenes/levels/level_1.tscn")
	elif actual_level.num_level == 2:
		get_tree().change_scene_to_file("res://Scenes/levels/level_2.tscn")
	elif actual_level.num_level == 3:
		get_tree().change_scene_to_file("res://Scenes/levels/level_3.tscn")
	elif actual_level.num_level == 4:
		get_tree().change_scene_to_file("res://Scenes/levels/level_4.tscn")
	elif actual_level.num_level == 5:
		get_tree().change_scene_to_file("res://Scenes/levels/level_5.tscn")

func _on_next_pressed() -> void:
	get_tree().paused = false
	if actual_level.num_level == 1:
		get_tree().change_scene_to_file("res://Scenes/levels/level_2.tscn")
	elif actual_level.num_level == 2:
		get_tree().change_scene_to_file("res://Scenes/levels/level_3.tscn")
	elif actual_level.num_level == 3:
		get_tree().change_scene_to_file("res://Scenes/levels/level_4.tscn")
	elif actual_level.num_level == 4:
		get_tree().change_scene_to_file("res://Scenes/levels/level_5.tscn")
	elif actual_level.num_level == 5:
		get_tree().change_scene_to_file("res://Scenes/levels.tscn")
