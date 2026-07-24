extends Area2D

signal level_complete


func _ready() -> void:
	$Open.visible = false
	monitoring = false

func open():
	$Closed.visible = false
	$Open.visible = true
	monitoring = true

func _on_body_entered(body: Node2D) -> void:
	level_complete.emit()
