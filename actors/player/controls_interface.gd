extends Control

@export var player_inventory: PlayerInventory

func _process(_delta: float) -> void:
	visible = !(get_tree().paused || player_inventory.active)
