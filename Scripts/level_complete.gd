extends CanvasLayer


func _ready() -> void:
	$PanelContainer/VBoxContainer/HBoxContainer/TextureRect.visible = false
	$PanelContainer/VBoxContainer/HBoxContainer/TextureRect2.visible = false
	$PanelContainer/VBoxContainer/HBoxContainer/TextureRect3.visible = false

func visibleCoins(coins):
	if coins >= 1:
		$PanelContainer/VBoxContainer/HBoxContainer/TextureRect.visible = true
	if coins >= 2:
		$PanelContainer/VBoxContainer/HBoxContainer/TextureRect2.visible = true
	if coins >= 3:
		$PanelContainer/VBoxContainer/HBoxContainer/TextureRect3.visible = true
