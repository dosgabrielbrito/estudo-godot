extends KinematicBody2D

enum PlayerDirection {
	LEFT,
	RIGHT,
}
onready var direction = PlayerDirection.RIGHT

enum PlayerState {
	IDLE,
	WALK,
}
onready var state = PlayerState.IDLE

var speed = 2000

var sfx_passos = []

func _ready():
	sfx_passos.push_front(load("res://Player/sfx/sfx_main_passo_1.mp3"))
	sfx_passos.push_front(load("res://Player/sfx/sfx_main_passo_2.mp3"))
	sfx_passos.push_front(load("res://Player/sfx/sfx_main_passo_3.mp3"))
	sfx_passos.push_front(load("res://Player/sfx/sfx_main_passo_4.mp3"))
	sfx_passos.push_front(load("res://Player/sfx/sfx_main_passo_5.mp3"))

func _process(delta):
	process_input()
	process_animation()
	
func process_input():
	var sfx_passos = randi() % 4
	
	if(Input.is_action_pressed("ui_left")):
		state = PlayerState.WALK
		direction = PlayerDirection.LEFT
	elif(Input.is_action_pressed("ui_right")):
		state = PlayerState.WALK
		direction = PlayerDirection.RIGHT
	else:
		state = PlayerState.IDLE

func process_animation():
	if (state == PlayerState.IDLE):
		$AnimatedSprite.animation = "idle"
	elif (state == PlayerState.WALK):
		$AnimatedSprite.animation = "walk"
	
	if (direction == PlayerDirection.LEFT):
		position.x = -1
	elif (direction == PlayerDirection.RIGHT):
		position.x = 1

func _physics_process(delta):
	var mov_delta = Vector2.ZERO
	
	if (state == PlayerState.WALK):
		if (direction == PlayerDirection.LEFT):
			mov_delta.x = -speed
		elif (direction == PlayerDirection.RIGHT):
			mov_delta.x = speed
			
	move_and_slide(mov_delta * delta, Vector2.UP)
