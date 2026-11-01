extends Control

@export var target: Node2D
@export var label: Label

func _ready() -> void:
	label.visible = false

func _on_interactable_module_focus_in() -> void:
	label.visible = true

func _on_interactable_module_focus_out() -> void:
	label.visible = false

func _on_interactable_module_interacted() -> void:
	print("Teste")
	if (target):
		target.queue_free()
