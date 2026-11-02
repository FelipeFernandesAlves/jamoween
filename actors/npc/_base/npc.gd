class_name NPC extends CharacterBody2D

@export var interactable: Interactable
@export var interaction_dialogue: DialogueResource
@export var interaction_area: Area2D

@export var outline_shader: Shader
@export var sprites: AnimatedSprite2D

@export var dialogue_icon: TextureRect
@export var dialogue_sine: Sine

func _ready() -> void:
	interactable.interacted.connect(_on_interacted)
	interactable.focus_in.connect(_on_focus_in)
	interactable.focus_out.connect(_on_focus_out)
	interactable.interaction_area = interaction_area

	dialogue_icon.visible = false

	if (sprites):
		sprites.material = ShaderMaterial.new()
		sprites.material.shader = outline_shader
		sprites.material.set_shader_parameter("active", false)
		sprites.material.set_shader_parameter("line_thickness", 1.0)

func _process(_delta: float) -> void:
	dialogue_icon.offset_transform_position.y = dialogue_sine.get_sine()

func _on_interacted():
	if (interaction_dialogue):
		DialogueManager.show_dialogue_balloon(interaction_dialogue)

func _on_focus_in():
	sprites.material.set_shader_parameter("active", true)
	dialogue_icon.visible = true

func _on_focus_out():
	sprites.material.set_shader_parameter("active", false)
	dialogue_icon.visible = false

func animate_vanish():
	interactable.active = false
	var tween = create_tween()
	tween.set_trans(Tween.TRANS_EXPO).set_ease(Tween.EASE_OUT)
	tween.tween_property(self, "modulate:a", 0.0, 2.0)
	tween.tween_callback(queue_free)
