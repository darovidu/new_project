extends Area2D

var speed = 100
var direction:Vector2 = Vector2.ZERO

@onready var player = get_tree().get_first_node_in_group("player")
@onready var tween = get_tree().create_tween()

func _ready() -> void:
	var distance = position.distance_to(player.position)
	var duration = distance / speed
	tween.tween_property(self, "position", player.position, duration)
	tween.tween_callback(destroy)

func _physics_process(delta: float) -> void:
	look_at(player.global_position)

func _on_body_entered(body: Node2D) -> void:
	destroy()

func destroy():
	tween.stop()
	tween.tween_callback(queue_free)
	queue_free()
