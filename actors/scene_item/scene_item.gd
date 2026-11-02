class_name SceneItem 
extends Node2D

@export var interactable: Interactable
@export var interaction_dialogue: DialogueResource
@export var interaction_area: Area2D

@export var outline_shader: Shader
@export var sprites: AnimatedSprite2D

@export var interaction_icon: TextureRect
@export var interaction_sine: Sine

@export var item: Item

func _ready() -> void:
	interactable.interacted.connect(_on_interacted)
	interactable.focus_in.connect(_on_focus_in)
	interactable.focus_out.connect(_on_focus_out)
	interactable.interaction_area = interaction_area

	interaction_icon.visible = false

	if (sprites):
		sprites.material = ShaderMaterial.new()
		sprites.material.shader = outline_shader
		sprites.material.set_shader_parameter("active", false)
		sprites.material.set_shader_parameter("line_thickness", 1.0)

func _process(_delta: float) -> void:
	interaction_icon.offset_transform_position.y = interaction_sine.get_sine()

func _on_interacted():
	if (interaction_dialogue):
		DialogueManager.show_dialogue_balloon(interaction_dialogue)
		await DialogueManager.dialogue_ended
	
	if (item):
		InventoryManager.add_item(item)
		queue_free()

func _on_focus_in():
	sprites.material.set_shader_parameter("active", true)
	interaction_icon.visible = true

func _on_focus_out():
	sprites.material.set_shader_parameter("active", false)
	interaction_icon.visible = false
