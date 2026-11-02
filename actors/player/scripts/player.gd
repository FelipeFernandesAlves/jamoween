class_name Player extends CharacterBody2D

@export var interaction_context: InteractionContext
@export var player_inventory: PlayerInventory
@export var player_sprites: AnimatedSprite2D

var move_dir: Vector2 = Vector2.ZERO
const SPEED = 400.0

func _physics_process(_delta: float) -> void:
	if (not Input.is_anything_pressed()):
		velocity = lerp(velocity, Vector2.ZERO, SPEED)
	
	velocity = move_dir * SPEED
	_handle_animate()
	move_and_slide()

func _unhandled_input(event: InputEvent) -> void:
	if (event.is_action_pressed("toggle_inventory") && !player_inventory.active):
		player_inventory.open()
	
	move_dir = Input.get_vector("left_direction", "right_direction", "up_direction", "down_direction")
	
func animate_death():
	pass

func _handle_animate():
	var animation: String = "idle"

	if (move_dir.length_squared() != 0):
		if (move_dir.y > 0):
			animation = "walk_bottom"
		elif (move_dir.y < 0):
			animation = "walk_up"
		elif (move_dir.x != 0):
			animation = "walk_side"

	player_sprites.flip_h = velocity.x < 0
	if (animation != player_sprites.animation):
		player_sprites.play(animation)
