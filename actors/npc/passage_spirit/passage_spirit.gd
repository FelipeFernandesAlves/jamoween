class_name PassageSpirit
extends NPC

func _ready() -> void:
	if (PersistenceKeyManager.check("passage_spirit_vanished", true)):
		queue_free()
	
	NpcContext.passage_spirit = self
	super()
