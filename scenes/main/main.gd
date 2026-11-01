extends Node2D

@export var default_balloon: PackedScene
@export var splash_screen: PackedScene
@export var initial_scene: PackedScene
@export var pause_menu: PackedScene
@export var scene_loader: SceneLoader
@export var control_parent: Control

var splash_screen_instance: SplashScreen

func _ready() -> void:
	# configure dialogue
	if (default_balloon):
		DialogueManager.set_default_balloon(default_balloon)

	# Instantiate splash screen
	if (splash_screen):
		splash_screen_instance = splash_screen.instantiate()
		splash_screen_instance.connect("splash_screen_ended", _start_game)
		control_parent.add_child(splash_screen_instance)
		return
	
	_start_game()
	
func _start_game():
	scene_loader.load_node2D(initial_scene.resource_path)
	await scene_loader.node2D_loaded
	if (splash_screen_instance):
		splash_screen_instance.queue_free()