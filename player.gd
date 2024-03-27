extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var animation_player = get_node("AnimationPlayer")

func _ready():
	animation_player.play("Idle")

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	update_animations()
	move_and_slide()

func update_animations():
	if velocity.x == 0:
		animation_player.play("Idle")
	else:
		animation_player.play("Run")
	
	if velocity.y < 0:
		animation_player.play("Jump")
	elif velocity.y > 0:
		animation_player.play("Fall")

	$AnimatedSprite2D.flip_h = velocity.x < 0
