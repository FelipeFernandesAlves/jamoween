class_name InitialCutsceneManager extends Node

@export var camera: Camera
@export var player: Player
@export var initial_dialogue: DialogueResource

@export var animation_player: AnimationPlayer
@export var sounds: Dictionary[String, AudioStreamPlayer]
@export var otherworld_items: Array[Node2D]

@export var emote: PackedScene
@export var emote_mark: Marker2D

@export var normal_tile_map: TileMapLayer

func start():
	get_tree().paused = true
	normal_tile_map.visible = true
	camera.zoom = Vector2(1.5, 1.5)
	camera.reset_camera()
	player.interaction_context.can_interact = false
	await get_tree().create_timer(1.5).timeout
	DialogueManager.show_dialogue_balloon(initial_dialogue)
	camera.animation_player.play("black_bars")
	hide_world()

func _input(event: InputEvent) -> void:
	if (event.is_action_pressed("interact")):
		camera.reset_smoothing()

func end():
	camera.use_subway_shake = false
	camera.animation_player.play_backwards("black_bars")
	var tween = create_tween()
	tween.set_ease(tween.EASE_OUT)
	tween.set_trans(Tween.TRANS_QUART)
	tween.tween_property(camera, "zoom", Vector2.ONE, 1.0)
	player.interaction_context.can_interact = true
	PersistenceKeyManager.set_key("seen_first_cutscene", true)
	normal_tile_map.visible = false
	if (!PersistenceKeyManager.get("world_changed")):
		change_world()

	get_tree().paused = false

func play_sound(sound_name: String, wait: bool = false):
	var parsed = sound_name.to_lower().strip_escapes()
	var sound: AudioStreamPlayer = sounds.get(parsed)
	
	if (sound):
		sound.play()
		if (wait):
			await sound.finished

		return
	
	push_warning("Sound not found.")

func play_animation(animation_name: String):
	animation_player.play(animation_name)
	await animation_player.animation_finished

func surprise_emote():
	var emote_instance: Emote = emote.instantiate()
	emote_instance.global_position = emote_mark.global_position
	add_child(emote_instance)
	await emote_instance.finished

func change_world():
	for i in otherworld_items:
		i.visible = true
	PersistenceKeyManager.set_key("world_changed", true)
	normal_tile_map.visible = false

func hide_world():
	for i in otherworld_items:
		i.visible = false
