class_name PlayerInventory
extends Control

@export var item_container: Control
@export var item_name_label: Label
@export var item_desc_label: Label
@export var player_item_packed: PackedScene
@export var item_carrousel: ItemCarousel

@export var debug_items: Array[Item]

var active: bool = false
var items: Array[InventoryItem]
var player_items: Array[PlayerInventoryItem]
var current_index: int

func _unhandled_input(event: InputEvent) -> void:
	if (!active):
		return
	
	var new_amount := 0
	if (event.is_action_pressed("ui_right")):
		new_amount = 1
	elif (event.is_action_pressed("ui_left")):
		new_amount = -1

	if (event.is_action_pressed("toggle_inventory")):
		close()
	
	# if (event.is_action_pressed("add_item_debug") && OS.is_debug_build()):
	# 	InventoryManager.add_item(debug_items.pick_random())
	# 	open()

	change_index(new_amount)
	get_window().set_input_as_handled()

func open():
	items = InventoryManager.get_items()
	player_items.clear()

	for n in item_container.get_children():
		item_container.remove_child(n)
		n.queue_free() 

	for item in items:
		if (!item || !item.item):
			continue

		var instance: PlayerInventoryItem = player_item_packed.instantiate()
		instance.inventory_item = item
		player_items.append(instance)
		item_container.add_child(instance)

	active = true
	current_index = 0
	get_tree().paused = true
	render_item()
	show()

func close():
	active = false
	get_tree().paused = false
	hide()

func change_index(amount: int):
	if (amount == 0):
		return
	
	var prev_index = current_index
	current_index = clamp(current_index + amount, 0, player_items.size()-1)
	if (current_index != prev_index):
		render_item(prev_index)

func render_item(prev_index: int = -1):
	item_name_label.text = ""
	item_desc_label.text = ""

	if (prev_index != -1):
		player_items[prev_index].focus_out()
	
	if (player_items.size() > 0):
		var data: InventoryItem = items[current_index]
		player_items[current_index].focus_in()
		item_name_label.text = data.item.name
		item_desc_label.text = data.item.desc
		item_carrousel.set_target_index(current_index)

		

	
