class_name Emote
extends Node2D

@export var distance: float = 20.0

signal finished()

func _ready() -> void:
	var tween := create_tween()
	tween.tween_property(self, "global_position:y", global_position.y - distance, 2.0)
	
	var op_tween := create_tween()
	op_tween.tween_property(self, "modulate:a", 0.0, 2.0)

	op_tween.finished.connect(
		func() -> void:
			finished.emit()
			queue_free()
	)
	