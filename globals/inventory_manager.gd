extends Node

var _items: Array[InventoryItem]

func _get_item_index(item_name: String):
	var res = -1
	for i in range(_items.size()):
		var item = _items[i]
		if (item.name == item_name):
			res = i
			break
	
	return res

func add_item(item: Item):
	var index = _get_item_index(item.name)
	if (index == -1):
		_items.append(InventoryItem.create(item, 1))
		return
	
	_items[index].quantity += 1

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

func get_items():
	return _items.map(func(inventory_item: InventoryItem): return inventory_item.item.duplicate())
