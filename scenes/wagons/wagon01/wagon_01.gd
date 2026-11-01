extends Node2D

@export var initial_cutscene_manager: InitialCutsceneManager

func _ready() -> void:
	if (!PersistenceKeyManager.check("seen_first_cutscene", true)):
		initial_cutscene_manager.start()
