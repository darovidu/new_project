extends CanvasLayer


var coins = 0

func _on_player_coin_signal() -> void:
	coins += 1
	$PanelContainer/VBoxContainer/HBoxContainer2/Label.text = str(coins)

func _on_player_hurt_signal(life: int) -> void:
	if life <= 2:
		$PanelContainer/VBoxContainer/HBoxContainer/Heart3.visible = false
	if life <= 1:
		$PanelContainer/VBoxContainer/HBoxContainer/Heart2.visible = false
	if life < 1:
		$PanelContainer/VBoxContainer/HBoxContainer/Heart1.visible = false
