extends Node2D

@export var player: Player

func _ready() -> void:
	player.interaction_context.can_interact = true
