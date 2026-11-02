class_name ItemCarousel
extends Control

@export var item_spacing: float = 180.0  
@export var lerp_speed: float = 12.0
@export var offset: Vector2 = Vector2.ZERO

var current_index: int = 0

func set_target_index(index: int) -> void:
	var total_items = get_child_count()
	if total_items == 0:
		return
	current_index = clamp(index, 0, total_items - 1)

func _process(delta: float) -> void:
	var items = get_children()
	if items.is_empty():
		return
		
	var screen_center_x = get_viewport_rect().size.x / 2.0
	var container_center_y = size.y / 2.0

	for i in range(items.size()):
		var item = items[i] as Control
		if not item:
			continue
			
		var offset_from_selected = i - current_index
		
		var target_x = screen_center_x + (offset_from_selected * item_spacing) - (item.size.x / 1.0) + offset.x
		var target_y = container_center_y - (item.size.y / 2.0) + offset.y
		
		# Animação de posição
		item.position.x = lerp(item.position.x, target_x, delta * lerp_speed)
		item.position.y = target_y
		
		# Animação de escala e opacidade (Efeito Silent Hill)
		var distance = abs(offset_from_selected)
		var target_scale = clamp(1.0 - (distance * 0.25), 0.5, 1.0)
		var target_alpha = clamp(1.0 - (distance * 0.35), 0.2, 1.0)
		
		item.scale = item.scale.lerp(Vector2(target_scale, target_scale), delta * lerp_speed)
		item.modulate.a = lerp(item.modulate.a, target_alpha, delta * lerp_speed)