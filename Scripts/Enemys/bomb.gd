extends CharacterBody2D


var speed = 50.0

var direction = -1
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var current_state:STATE = STATE.WALK
var angry:bool = false
var fast_explode:bool = true

enum STATE {
	WALK,
	TURN,
	EXPLODE
}

func _physics_process(delta: float) -> void:
	match current_state:
		STATE.WALK:
			if direction == 1:
				if angry:
					speed = 100.0
					$Animations.play("walk_angry_R")
				else:
					speed = 50.0
					$Animations.play("walk_R")
			else:
				if angry:
					speed = 100.0
					$Animations.play("walk_angry_L")
				else:
					speed = 50.0
					$Animations.play("walk_L")
			
			velocity.x = direction * speed
			
			if is_on_wall():
				if angry:
					current_state = STATE.EXPLODE
				else:
					current_state = STATE.TURN
				
			if $RayCastPlayer.is_colliding():
				angry = true
				$TimerRayCast.start()
			
			if !$RayCastFloor.is_colliding() and angry == false:
				current_state = STATE.TURN
			
		STATE.TURN:
			if direction == 1:
				$Animations.play("turn_R")
				direction = -1
				$RayCastPlayer.target_position.x = -108
				$RayCastFloor.position.x = -3
			else:
				$Animations.play("turn_L")
				direction = 1
				$RayCastPlayer.target_position.x = 108
				$RayCastFloor.position.x = 4
			
			current_state = STATE.WALK
		
		STATE.EXPLODE:
			if fast_explode:
				$Animations.play("fast_explode")
			else:
				$Animations.play("explode")
	
	move_and_slide()
	
	if current_state != STATE.EXPLODE:
		handle_gravity(delta)

func handle_gravity(delta):
	velocity.y += gravity * delta

func _on_timer_ray_cast_timeout() -> void:
	angry = false

func _on_explosion_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		body.hurt(2)
	elif body.is_in_group("block"):
		body.destroy()
	else:
		body.death()

func death():
	fast_explode = false
	current_state = STATE.EXPLODE
