extends CanvasLayer


var coins = 0

func _on_player_coin_signal() -> void:
	coins += 1
	$PanelContainer/VBoxContainer/HBoxContainer2/Label.text = str(coins)
