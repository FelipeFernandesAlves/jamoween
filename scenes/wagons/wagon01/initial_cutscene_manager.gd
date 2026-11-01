class_name InitialCutsceneManager extends Node

@export var camera: Camera
@export var player: Player
@export var initial_dialogue: DialogueResource

@export var animation_player: AnimationPlayer
@export var clock_sfx: AudioStreamPlayer

func start():
	get_tree().paused = true
	camera.zoom = Vector2(1.5, 1.5)
	camera.reset_camera()
	await get_tree().create_timer(1.5).timeout
	DialogueManager.show_dialogue_balloon(initial_dialogue)

func _input(event: InputEvent) -> void:
	if (event.is_action_pressed("interact")):
		camera.reset_smoothing()

func end():
	camera.use_subway_shake = false
	var tween = create_tween()
	tween.set_ease(tween.EASE_OUT)
	tween.set_trans(Tween.TRANS_QUART)
	tween.tween_property(camera, "zoom", Vector2.ONE, 0.5)

	get_tree().paused = false

func play_clock():
	clock_sfx.play()
	await clock_sfx.finished

func play_animation(animation_name: String):
	animation_player.play(animation_name)
	await animation_player.animation_finished
