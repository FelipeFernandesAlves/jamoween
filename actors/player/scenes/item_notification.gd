class_name ItemNotification
extends HBoxContainer

@export var label: Label
@export var texture_rect: TextureRect
var inventory_item: InventoryItem
var quantity: int

func _ready() -> void:
	label.text = inventory_item.item.name + str(" +", quantity) if quantity > 0 else str(" ", quantity)
	texture_rect.texture = inventory_item.item.texture
	var tween = create_tween()
	tween.set_trans(Tween.TRANS_QUART).set_ease(Tween.EASE_OUT)
	tween.tween_property(self, "offset_transform_position:y", 0.0, 0.75)

	await tween.finished
	await get_tree().create_timer(1.8).timeout

	if(tween):
		tween.kill()

	tween = create_tween()
	tween.set_trans(Tween.TRANS_QUART).set_ease(Tween.EASE_OUT)
	tween.tween_property(self, "modulate:a", 0.0, 0.75)
	tween.tween_callback(queue_free)
