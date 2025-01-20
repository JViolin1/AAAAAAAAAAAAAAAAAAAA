extends CharacterBody2D

var player_chase = false
var player = null
var enemy_move : Vector2
var flip = 1
var anim : int
var health = 3
const ENEMY_SPEED = 200

func _ready():
	var random = randi_range(0, 1)
	if random == 0:
		position.x = randi_range(0, 1) * 1920
		position.y = randi_range(0, 1080)
	else:
		position.x = randi_range(0, 1920)
		position.y = randi_range(0, 1) * 1080
	$ProgressBar.value = 3

func _process(delta):
	if player_chase:
		enemy_move.x = 0
		enemy_move.y = 0
		if abs(player.position.x - position.x) > 15:
			anim = 1
			enemy_move.x += ((player.position.x - position.x) / abs(player.position.x - position.x)) * ENEMY_SPEED * delta
			if flip == -1 * (player.position.x - position.x) / abs(player.position.x - position.x):
				flip = (player.position.x - position.x) / abs(player.position.x - position.x)
				scale.x = -1
		if abs(player.position.y - position.y) > 15:
			anim = 1
			enemy_move.y += ((player.position.y - position.y) / abs(player.position.y - position.y)) * ENEMY_SPEED * delta
		move_and_collide(enemy_move)
		
		if anim == 1:
			$AnimatedSprite2D.play("Walk")
		else:
			$AnimatedSprite2D.play("Idle")
	if health < 1:
		if health < 0:
			queue_free()
		else:
			health -= 1

func _on_area_2d_body_entered(body):
	player = body
	player_chase = true

func _on_area_2d_body_exited(body):
	player = null
	player_chase = false

func _on_bullet_detect_body_entered(body):
	health -= 1
	$ProgressBar.value = health
	$HitSound.play()
	move_and_collide(enemy_move * -5)
