extends CharacterBody2D


const SPEED = 50.0
const JUMP_VELOCITY = -400.0

var direction = -1
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@export var color:String
@export var coin:bool

@onready var player = get_tree().get_first_node_in_group("player")


func _physics_process(delta: float) -> void:
	if is_on_wall() or !$RayCast2D.is_colliding():
		turn()
	
	if direction == -1:
		change_animation("walk_L")
	else:
		change_animation("walk_R")
	
	velocity.x = direction * SPEED
	
	handle_gravity(delta)
	move_and_slide()

func handle_gravity(delta):
	velocity.y += gravity * delta

func turn():
	if direction == -1:
		direction = 1
		$RayCast2D.position.x = 5
	else:
		direction = -1
		$RayCast2D.position.x = -5

func death():
	if coin:
		player.coin()
	queue_free()

func change_animation(animation):
	if color == "orange":
		if animation == "walk_L":
			$Animations.play("walk_L_1")
		elif animation == "walk_R":
			$Animations.play("walk_R_1")
	elif color == "yellow":
		if animation == "walk_L":
			$Animations.play("walk_L_2")
		elif animation == "walk_R":
			$Animations.play("walk_R_2")
	elif color == "purple":
		if animation == "walk_L":
			$Animations.play("walk_L_3")
		elif animation == "walk_R":
			$Animations.play("walk_R_3")
