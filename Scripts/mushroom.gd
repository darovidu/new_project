extends CharacterBody2D


const SPEED = 50.0
const JUMP_VELOCITY = -400.0

var direction = -1
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@export var color:int = 1


func _physics_process(delta: float) -> void:
	if is_on_wall():
		turn()
	
	if direction == -1:
		$Animations.play("walk_L_1")
	else:
		$Animations.play("walk_R_1")
	
	velocity.x = direction * SPEED
	
	handle_gravity(delta)
	move_and_slide()

func handle_gravity(delta):
	velocity.y += gravity * delta

func turn():
	if direction == -1:
		direction = 1
	else:
		direction = -1

func death():
	queue_free()


func _on_hurt_box_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		body.hurt()
