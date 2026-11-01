extends CharacterBody2D

const SPEED = 400.0

func _physics_process(_delta: float) -> void:

	var direction := Input.get_vector("left_direction", "right_direction", "down_direction", "up_direction")
	velocity = direction * SPEED

	move_and_slide()
