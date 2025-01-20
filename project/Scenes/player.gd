extends CharacterBody2D

@onready var main = $".."

const PLAYER_SPEED = 500
var player_move : Vector2
var flip = 1
var bullet_scene := preload("res://Scenes/bullet.tscn")
var shoot = 0
var health = 5
var powerup = 0

func _ready():
	$"../ProgressBar".value = 5

func _process(delta):
	player_move.x = 0
	player_move.y = 0
	
	if Input.is_action_pressed("ui_right"):
		player_move.x += PLAYER_SPEED * delta
		if flip == -1 and not Input.is_action_pressed("ui_left"):
			flip = 1
			scale.x = -1
	if Input.is_action_pressed("ui_left"):
		player_move.x -= PLAYER_SPEED * delta
		if flip == 1 and not Input.is_action_pressed("ui_right"):
			flip = -1
			scale.x = -1
	if Input.is_action_pressed("ui_down"):
		player_move.y += PLAYER_SPEED * delta
	if Input.is_action_pressed("ui_up"):
		player_move.y -= PLAYER_SPEED * delta
	
	move_and_collide(player_move)
	
	if abs(player_move.x) > 0 or abs(player_move.y) > 0:
		$AnimatedSprite2D.play("Walk")
	else:
		$AnimatedSprite2D.play("Idle")
	
	position.x = clamp(position.x, 0, 1920)
	position.y = clamp(position.y, 0, 1080)
	
	if Input.is_action_pressed("shoot"):
		if shoot > 0.2:
			shoot = 0
			$"../ShootSound".play()
			var bullet = bullet_scene.instantiate()
			bullet.position = position
			main.add_child(bullet)
	shoot += delta
	
	if health < 1:
		get_tree().reload_current_scene()

func _on_area_2d_body_entered(body):
	health -= 1
	$"../ProgressBar".value = health
	$"../HitSound".play()

func _on_powerupdetect_body_entered(body):
	powerup = 30
