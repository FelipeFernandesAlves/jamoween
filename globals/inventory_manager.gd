extends Node

signal item_added(inventory_item: InventoryItem, quantity: int)
var _items: Array[InventoryItem]

func _get_item_index(item_name: String):
	var res = -1
	for i in range(_items.size()):
		var inventory_item = _items[i]
		if (inventory_item.item.name == item_name):
			res = i
			break
	
	return res

func add_item(item: Item):
	if (!item):
		return

	var index = _get_item_index(item.name)
	if (index == -1):
		var inventory_item = InventoryItem.create(item, 1)
		_items.append(inventory_item)
		item_added.emit(inventory_item, 1)
		return
	
	_items[index].quantity += 1

func add_item_by_path(path: String):
	var item = load(path)
	if (item is Item):
		add_item(item)
		return
	push_warning("item path: " + path + " is not valid!")

func remove_item(item: Item):
	var index = _get_item_index(item.name)
	if (index == -1):
		return
	
	_items[index].quantity -= 1

	if (_items[index].quantity <= 0):
		_items.remove_at(index)

func has_item(item_name: String):
	return _get_item_index(item_name) != -1

func item_quantity(item_name: String) -> int:
	var index = _get_item_index(item_name)
	if (index == -1):
		return index

	return _items[index].quantity

func get_items() -> Array[InventoryItem]:
	return _items
