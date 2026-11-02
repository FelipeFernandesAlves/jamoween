extends Node2D

@export var initial_cutscene_manager: InitialCutsceneManager

func _ready() -> void:
	if (!PersistenceKeyManager.check("seen_first_cutscene", true)):
		initial_cutscene_manager.start()
	else:
		initial_cutscene_manager.end()

	if (PersistenceKeyManager.check("world_changed", true)):
		initial_cutscene_manager.change_world()
	else:
		initial_cutscene_manager.hide_world()
