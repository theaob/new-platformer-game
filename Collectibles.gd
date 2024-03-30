extends Node2D

const CHERRY_SCENE = preload("res://cherry.tscn")

func _on_timer_timeout():
	var cherry_instance = CHERRY_SCENE.instantiate()
	var rng = RandomNumberGenerator.new()
	var x_rand = rng.randi_range(0, 300)
	
	cherry_instance.position = Vector2(x_rand,390)
	get_node("Cherries").add_child(cherry_instance)
	
