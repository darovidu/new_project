extends Area2D

@export var door:Node2D


func _on_body_entered(body: Node2D) -> void:
	door.open()
	queue_free()
