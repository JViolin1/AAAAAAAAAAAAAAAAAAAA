extends CharacterBody2D

@onready var mouse_pos = get_global_mouse_position()
const BULLET_SPEED = 1500
@onready var bullet_velocity = (mouse_pos - position).normalized() * BULLET_SPEED
var death = 0
var angle : int

func _ready():
	look_at(get_global_mouse_position())
	rotation += angle
	bullet_velocity = bullet_velocity.rotated(deg_to_rad(angle))

func _process(delta):
	move_and_collide(bullet_velocity * delta)
	if death > 0:
		if death > 1:
			queue_free()
		else:
			death += 1

func _on_area_2d_body_entered(body):
	death = 1
