class_name InventoryItem
extends Resource

@export var item: Item
@export var quantity: int

static func create(_item: Item, _quantity: int) -> InventoryItem:
	var inventory_item = InventoryItem.new()
	inventory_item.item = _item
	inventory_item.quantity = _quantity
	return inventory_item


