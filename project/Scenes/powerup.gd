extends StaticBody2D

var disappear = 0

func _ready():
	position.x = randi_range(0, 1920)
	position.y = randi_range(0, 1080)

func _process(delta):
	if disappear > 0:
		disappear += 1
	if disappear > 2:
		queue_free()

func _on_body_entered(body):
	disappear = 1
