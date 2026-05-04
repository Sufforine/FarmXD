extends CharacterBody3D

@export var speed := 5.0

@onready var anim = $AnimatedSprite3D

var facing_right := true

func _physics_process(delta):
	var input_dir = Vector2.ZERO

	input_dir.x = Input.get_action_strength("Right") - Input.get_action_strength("Left")
	input_dir.y = Input.get_action_strength("Down") - Input.get_action_strength("Up")

	input_dir = input_dir.normalized()

	var direction = Vector3(input_dir.x, 0, input_dir.y)

	velocity.x = direction.x * speed
	velocity.z = direction.z * speed

	move_and_slide()

	# --- направление взгляда ---
	if input_dir.x > 0:
		facing_right = true
	elif input_dir.x < 0:
		facing_right = false

	anim.flip_h = not facing_right

	# --- анимация ---
	if input_dir == Vector2.ZERO:
		anim.play("idle")
	else:
		anim.play("run")
