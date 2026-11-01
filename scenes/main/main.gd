extends Node2D

@export var initial_scene: PackedScene

func _ready() -> void:
	get_tree().change_scene_to_packed.call_deferred(initial_scene)