extends Area2D

@export var speed: int = 400
var screen_size: Vector2
var velocity = Vector2.ZERO


func clamp_player(delta):
	position += velocity * delta
	position = position.clamp(Vector2.ZERO, screen_size) 


func check_input():
	var l_velocity = Vector2.ZERO
	if Input.is_action_pressed("move_right"):
		l_velocity.x += 1
	if Input.is_action_pressed("move_left"):
		l_velocity.x -= 1
	if Input.is_action_pressed("move_back"):
		l_velocity.y += 1
	if Input.is_action_pressed("move_up"):
		l_velocity.y -= 1

	if l_velocity.length() > 0:
		velocity = l_velocity.normalized() * speed
		$AnimatedSprite2D.play()
	else:
		$AnimatedSprite2D.stop()


# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	check_input()
	clamp_player(delta)

