class_name Player extends CharacterBody2D

@export var interaction_context: InteractionContext

const SPEED = 400.0

func _physics_process(_delta: float) -> void:
	var direction := Input.get_vector("left_direction", "right_direction", "up_direction", "down_direction")
	velocity = direction * SPEED

	move_and_slide()
