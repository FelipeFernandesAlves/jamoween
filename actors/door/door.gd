class_name Door
extends NPC

@export var required_key: String
@export var next_room_path: String

var can_open: bool:
	get():
		if (required_key && required_key != ""):
			return PersistenceKeyManager.check(required_key, true)
		return true

func _on_interacted():
	super()
	if (can_open):
		SceneManager.instance.load_node2D(next_room_path)
	
func _process(_delta: float) -> void:
	super(_delta)
	interactable.active = can_open