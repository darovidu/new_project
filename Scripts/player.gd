class_name Player extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -350.0

signal coin_signal(lifes:int)
signal hurt_signal

var iframes = false
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var life:int = 3
var safe_position:Vector2 = Vector2.ZERO

enum STATE {
	IDLE,
	WALK,
	JUMP,
	FALL,
	ATTACK,
	HURT,
	DIE
}

var current_state:STATE = STATE.IDLE


func _input(event: InputEvent) -> void:
	match current_state:
		STATE.IDLE:
			if Input.is_action_pressed("left") or Input.is_action_pressed("right"):
				current_state = STATE.WALK
			elif Input.is_action_just_pressed("jump"):
				current_state = STATE.JUMP
			elif Input.is_action_pressed("attack"):
				current_state = STATE.ATTACK
		STATE.WALK:
			if not Input.is_action_pressed("left") and not Input.is_action_pressed("right"):
				current_state = STATE.IDLE
			elif Input.is_action_pressed("jump"):
				current_state = STATE.JUMP
			elif Input.is_action_pressed("attack"):
				current_state = STATE.ATTACK

func _physics_process(delta: float) -> void:
	match  current_state:
		STATE.IDLE:
			velocity.x = 0
			$Animations.play("idle")
			
			if not is_on_floor():
				current_state = STATE.FALL
			
		STATE.WALK:
			flip()
			velocity.x = Input.get_axis("left", "right") * SPEED
			$Animations.play("walk")
			
			if not is_on_floor():
				current_state = STATE.FALL
			
		STATE.JUMP:
			$HitBox.position.y = 0.5
			flip()
			$Animations.play("jump")
			velocity.x = Input.get_axis("left", "right") * SPEED
			if is_on_floor() and velocity.y >= 0:
				velocity.y = JUMP_VELOCITY
			if velocity.y > 0:
				current_state = STATE.FALL
				
		STATE.FALL:
			$HitBox.position.y = 5.5
			flip()
			$Animations.play("fall")
			velocity.x = Input.get_axis("left", "right") * SPEED
			if velocity.y >= 0 and is_on_floor():
				if Input.is_action_pressed("left") or Input.is_action_pressed("right"):
					current_state = STATE.WALK
				else:
					current_state = STATE.IDLE
				
		STATE.ATTACK:
			velocity.x = 0
			$Animations.play("attack")
			
		STATE.HURT:
			iframes = true
			velocity.x = 0
			$Animations.play("hurt")
			#$Timer.start()
			#current_state = STATE.IDLE
		
		STATE.DIE:
			$HitBox.disabled = true
			$Animations.play("die")
	
	if life <= 0:
		current_state = STATE.DIE
	
	if is_on_floor():
		safe_position = position
		if Input.is_action_pressed("left"):
			safe_position.x += 10
		elif Input.is_action_pressed("right"):
			safe_position.x -= 10
	
	#var collision
	#for i in get_slide_collision_count():
		#collision = get_slide_collision(i)
		#for j in get_tree().get_nodes_in_group("enemy"):
			#if collision.get_collider() == j:
				#hurt(1)
	
	if current_state != STATE.DIE:
		handle_gravity(delta)
	move_and_slide()

func handle_gravity(delta):
	velocity.y += gravity * delta

func finish_animation():
	print(life)
	current_state = STATE.IDLE

func heal(healthUp):
	life += healthUp

func hurt(damage):
	if iframes == false:
		life -= damage
		current_state = STATE.HURT
		hurt_signal.emit(life)

func coin():
	coin_signal.emit()

func flip():
	if Input.is_action_pressed("left"):
		$HitBox.position.x = -2
		$Attack/HurtBox.position.x = -13.5
		$Sprites.flip_h = true
	elif Input.is_action_pressed("right"):
		$HitBox.position.x = 2
		$Attack/HurtBox.position.x = 13.5
		$Sprites.flip_h = false

func _on_attack_body_entered(body: Node2D) -> void:
	body.death()

func _on_timer_timeout() -> void:
	iframes = false
	print("a")

func _on_hurt_zone_body_entered(body: Node2D) -> void:
	position = safe_position
	life -= 1
	hurt_signal.emit(life)
