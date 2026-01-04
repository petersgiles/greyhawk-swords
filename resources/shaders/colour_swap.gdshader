// Color Replacement

shader_type canvas_item;

uniform bool enable_color_1 = false;
uniform vec4 old_color_1: source_color = vec4(1.0);
uniform vec4 new_color_1: source_color = vec4(1.0);

uniform bool enable_color_2 = false;
uniform vec4 old_color_2: source_color = vec4(1.0);
uniform vec4 new_color_2: source_color = vec4(1.0);

uniform float tolerance: hint_range(0.0, 1.0) = 0.1;

void fragment() {
	vec4 color = texture(TEXTURE, UV);
	
	if (enable_color_1 && distance(color.rgb, old_color_1.rgb) < tolerance) {
		color.rgb = new_color_1.rgb;
	}
	
	if (enable_color_2 && distance(color.rgb, old_color_2.rgb) < tolerance) {
		color.rgb = new_color_2.rgb;
	}
	
	COLOR = color;
}