extends Node

@onready var main = $".."

var enemy_scene := preload("res://Scenes/enemy.tscn")

func _on_enemy_countdown_timeout():
	for i in 5:
		var enemy = enemy_scene.instantiate()
		main.add_child(enemy)
		$"../EnemyCountdown".wait_time = (1.5 - $"../EnemyCountdown".wait_time) / 30
