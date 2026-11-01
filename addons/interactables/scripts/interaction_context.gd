class_name InteractionContext
extends Node

@export var target: PhysicsBody2D:
	set(value):
		if (target):
			InteractionManager.remove_context_body(target)

		if (value):
			InteractionManager.add_context_body(value)

		target = value

@export var interaction_input: StringName = "ui_accept"

func _unhandled_input(event: InputEvent) -> void:
	if (event.is_action_pressed(interaction_input)):
		InteractionManager.interaction_request()
		get_viewport().set_input_as_handled()

func _enter_tree() -> void:
	if (target):
		InteractionManager.add_context_body(target)

func _exit_tree() -> void:
	if (target):
		InteractionManager.remove_context_body(target)