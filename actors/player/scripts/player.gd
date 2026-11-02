class_name Player extends CharacterBody2D

@export var interaction_context: InteractionContext
@export var player_inventory: PlayerInventory

var move_dir: Vector2 = Vector2.ZERO
const SPEED = 400.0

func _physics_process(_delta: float) -> void:
	if (not Input.is_anything_pressed()):
		velocity = lerp(velocity, Vector2.ZERO, SPEED)
	
	velocity = move_dir * SPEED
	move_and_slide()

func _unhandled_input(event: InputEvent) -> void:
	if (event.is_action_pressed("toggle_inventory") && !player_inventory.active):
		player_inventory.open()
	
	move_dir = Input.get_vector("left_direction", "right_direction", "up_direction", "down_direction")
	
func animate_death():
	pass
