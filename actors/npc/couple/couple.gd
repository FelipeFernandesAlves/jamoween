extends NPC

func _ready() -> void:
	if (PersistenceKeyManager.check("couple_vanished", true)):
		queue_free()

	NpcContext.couple = self
	super()