extends Node

var _context_bodies: Array[PhysicsBody2D]
var _active_interactables: Array[Interactable]
var current_interactable: Interactable

signal interactable_changed(interactable: Interactable)

func add_context_body(body: PhysicsBody2D):
	if (!body in _context_bodies):
		_context_bodies.push_back(body)

func remove_context_body(body: PhysicsBody2D):
	_context_bodies.erase(body)

func interactable_area_body_entered(body: Node2D, interactable: Interactable):
	if (body in _context_bodies && !interactable in _active_interactables):
		if (!interactable.target):
			push_warning("Interactable without parent!")
			return

		_active_interactables.append(interactable)
	
func interactable_area_body_exited(body: Node2D, interactable: Interactable):
	if (body in _context_bodies):
		_active_interactables.erase(interactable)

func update_interactable():
	_active_interactables = _active_interactables.filter(func(interactable:Interactable): return interactable.active)
	_active_interactables.sort_custom(_interactable_sort)

	var first = null
	if (_active_interactables.size() > 0):
		first = _active_interactables.front()

	if (first != current_interactable):
		if (current_interactable):
			current_interactable.focus_out.emit()

		if (first):
			first.focus_in.emit()

		interactable_changed.emit(first)
		current_interactable = first

func interaction_request():
	if (current_interactable):
		current_interactable.interacted.emit()

func _interactable_sort(a: Interactable, b: Interactable):
	return _get_average_dist(a.target, _context_bodies) < _get_average_dist(b.target, _context_bodies)

func _get_average_dist(node: Node2D, targets: Array[PhysicsBody2D]):
	var sum = func (accum: int, target: PhysicsBody2D): 
		return accum + target.global_position.distance_squared_to(node.global_position)

	return targets.reduce(sum, 0)

func _physics_process(_delta: float) -> void:
	update_interactable()