class_name PlayerInventoryItem
extends MarginContainer

@export var select_icon: TextureRect
@export var item_texture: TextureRect
@export var inventory_item: InventoryItem:
	set(value):
		inventory_item = value
		if (item_texture):
			if (inventory_item && inventory_item.item):
					item_texture.texture = inventory_item.item.texture
			else:
				item_texture.texture = null

var tween: Tween

func focus_in():
	select_icon.visible = true
	if (tween):
		tween.kill()
	
	tween = create_tween()
	tween.set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
	tween.tween_property(self, "theme_override_constants/margin_bottom", 10, 0.5)

func focus_out():
	select_icon.visible = false
	if (tween):
		tween.kill()
	
	tween = create_tween()
	tween.set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
	tween.tween_property(self, "theme_override_constants/margin_bottom", 0, 0.5)
