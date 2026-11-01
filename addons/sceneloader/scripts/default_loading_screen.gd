extends LoadingScreen

@export var animation_player: AnimationPlayer

func _ready() -> void:
	animation_player.play("transition")
	await animation_player.animation_finished
	loading_screen_ready.emit()

func _on_load_finished():
	animation_player.play_backwards("transition")
	await animation_player.animation_finished
	queue_free()
