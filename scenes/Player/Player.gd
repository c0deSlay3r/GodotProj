extends Area2D

@export var speed: int = 400
var screen_size: Vector2
var velocity = Vector2.ZERO


func clamp_player(delta):
	position += velocity * delta
	position = position.clamp(Vector2.ZERO, screen_size) 

func choose_animation():
	if velocity.x != 0:
		$AnimatedSprite2D.animation = "walk"
		$AnimatedSprite2D.flip_v = false

		$AnimatedSprite2D.flip_h = velocity.x < 0
	elif velocity.y != 0:
		$AnimatedSprite2D.animation = "up"
		$AnimatedSprite2D.flip_v = velocity.y > 0


func check_input(delta):
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
	
	clamp_player(delta)


# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	check_input(delta)

	choose_animation()

