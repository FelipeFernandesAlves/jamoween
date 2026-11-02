extends PointLight2D

@export var noise_gen: NoiseGen
@export var texture_scale_base: float = 1.0

func _process(_delta: float) -> void:
	texture_scale = texture_scale_base + noise_gen.get_noise_1d()
