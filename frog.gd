extends CharacterBody2D

@export var SPEED = 100

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var player
var chase = false

func _ready():
	$AnimatedSprite2D.play("idle")
	chase = false

func _physics_process(delta):
	velocity.y += gravity * delta
	
	if chase:
		player = $"../../Player/Player"
		if $AnimatedSprite2D.animation != "death":		
			$AnimatedSprite2D.play("jump")
		
		var move_direction  = (player.position - self.position).normalized().x
		if move_direction > 0:
			$AnimatedSprite2D.flip_h = true
		else:
			$AnimatedSprite2D.flip_h = false
			
		velocity.x = move_direction * SPEED
	else:
		velocity.x = 0
		if $AnimatedSprite2D.animation != "death":
			$AnimatedSprite2D.play("idle")
		
	move_and_slide()

func _on_player_detection_body_entered(body):
	if body.name == "Player":
		chase = true

func _on_player_detection_body_exited(body):
	if body.name == "Player":
		chase = false

func _on_player_death_body_entered(body):
	if body.name == "Player":
		chase = false
		die()

func _on_player_collision_body_entered(body):
	if body.name == "Player":
		body.hurt()
		die()

func die():
	$AnimatedSprite2D.play("death")
	await $AnimatedSprite2D.animation_finished
	self.queue_free()
