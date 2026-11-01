class_name Interactable
extends Node

@export var interaction_area: Area2D:
	set(value):
		interaction_area = value
		if (interaction_area):
			interaction_area.body_entered.connect(_on_body_entered)
			interaction_area.body_exited.connect(_on_body_exited)

@export var target: Node2D
@export var active: bool = true:
	set(value):
		active = value

signal focus_in()
signal focus_out()
signal interacted()

func _on_body_entered(body: Node2D):
	InteractionManager.interactable_area_body_entered(body, self)

func _on_body_exited(body: Node2D):
	InteractionManager.interactable_area_body_exited(body, self)