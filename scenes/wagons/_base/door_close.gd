extends AudioStreamPlayer

func _ready() -> void:
	if (PersistenceKeyManager.check("door_opened", true)):
		PersistenceKeyManager.set_key("door_opened", false)
		play()