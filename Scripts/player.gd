class_name Player extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0


var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

enum STATE {
	IDLE,
	WALK,
	JUMP,
	FALL,
	HURT,
	DIE
}

var current_state:STATE = STATE.IDLE


func _input(event: InputEvent) -> void:
	match current_state:
		STATE.IDLE:
			if Input.is_action_pressed("left") or Input.is_action_pressed("right"):
					current_state = STATE.WALK
			elif Input.is_action_pressed("jump"):
				current_state = STATE.JUMP
		STATE.WALK:
			if not Input.is_action_pressed("left") and not Input.is_action_pressed("right"):
				current_state = STATE.IDLE
			elif Input.is_action_pressed("jump"):
				current_state = STATE.JUMP


func _physics_process(delta: float) -> void:
	match  current_state:
		STATE.IDLE:
			velocity.x = 0
			$Animations.play("idle")
		STATE.WALK:
			velocity.x = Input.get_axis("left", "right") * SPEED
			$Animations.play("walk")
		STATE.JUMP:
			$Animations.play("jump")
			velocity.x = Input.get_axis("left", "right") * SPEED
			if is_on_floor() and velocity.y >= 0:
				velocity.y = JUMP_VELOCITY
			if velocity.y > 0:
				current_state = STATE.FALL
		STATE.FALL:
			$Animations.play("fall")
			velocity.x = Input.get_axis("left", "right") * SPEED
			if velocity.y >= 0 and is_on_floor():
				if Input.is_action_pressed("left") or Input.is_action_pressed("right"):
					current_state = STATE.WALK
				else:
					current_state = STATE.IDLE
		STATE.HURT:
			$Animations.play("hurt")
		STATE.DIE:
			$Animations.play("die")
	
	if Input.is_action_pressed("left"):
		$Sprites.flip_h = true
	elif Input.is_action_pressed("right"):
		$Sprites.flip_h = false
	
	handle_gravity(delta)
	move_and_slide()

func handle_gravity(delta):
	velocity.y += gravity * delta

func finish_animation():
	current_state = STATE.IDLE
