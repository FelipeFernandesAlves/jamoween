shader_type canvas_item;

uniform float width: hint_range(0.0, 1.0, 0.01) = 0.1;
uniform float progression: hint_range(0.0, 1.0, 0.01) = 0.0;

void fragment() {
	float upper_bar = step(UV.y, width*progression);
	float lower_bar = step(1.0 - UV.y, width*progression);
	
	COLOR.a = (upper_bar + lower_bar);
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
