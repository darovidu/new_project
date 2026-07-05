extends CharacterBody2D

const SPEED = 3.0
const STINGER:PackedScene = preload("res://Scenes/stinger.tscn")

var current_state:STATE = STATE.IDLE

@onready var inicial_position:Vector2 = position
@onready var tween = get_tree().create_tween()

enum STATE {
	IDLE,
	WALK,
	ANGRY
}


func _ready() -> void:
	move(false)

func _physics_process(delta: float) -> void:
	match current_state:
		STATE.IDLE:
			$Animations.play("idle_L")
		
		STATE.ANGRY:
			$Animations.play("attack_L")
			await($Animations.animation_finished)
			shoot()
	
	move_and_slide()

func _on_detection_area_body_entered(body: Node2D) -> void:
	current_state = STATE.ANGRY

func _on_detection_area_body_exited(body: Node2D) -> void:
	$Timer.start()

func shoot():
	var instance = STINGER.instantiate()
	instance.global_position = $Marker2D.global_position
	#instance.direction = 
	get_parent().add_child(instance)

func move(kill):
	if kill:
		tween.kill()
	else:
		var final_position = inicial_position.x-40
		tween.tween_property(self, "position:x", final_position, 2)
		final_position = inicial_position.x+40
		tween.tween_property(self, "position:x", final_position, 2)
		tween.set_loops()

func _on_timer_timeout() -> void:
	current_state = STATE.IDLE
