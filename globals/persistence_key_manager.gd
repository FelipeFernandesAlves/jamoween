extends Node

const SAVE_FILE_PATH := ""
var _persistence_keys: Dictionary[String, Variant] = {}

func check(key_name: String, value: Variant):
	return _persistence_keys.get(key_name) == value

func set_key(key_name: String, value: Variant):
	_persistence_keys.set(key_name, value)

func get_key(key_name: String):
	return _persistence_keys.get(key_name)

func save():
	pass

func load():
	pass
