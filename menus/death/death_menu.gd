extends Control

func _input(event: InputEvent) -> void:
	if (event.is_action_pressed("restart")):
		SceneManager.instance.restart_node2D_scene()
		SceneManager.instance.remove_control()
	