extends NPC

func _ready() -> void:
	if (PersistenceKeyManager.check("possessive_spirit_vanished", true)):
		queue_free()
	super()
	NpcContext.possessive_spirit = self