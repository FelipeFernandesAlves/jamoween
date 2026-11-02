extends Control

@export var item_notification_scene: PackedScene
@export var parent: Node

func _ready() -> void:
	InventoryManager.item_added.connect(_on_item_added)
	if (!parent):
		parent = self

func _on_item_added(inventory_item: InventoryItem, quantity: int):
	var instance: ItemNotification = item_notification_scene.instantiate()
	instance.inventory_item = inventory_item
	instance.quantity = quantity
	parent.add_child(instance)
