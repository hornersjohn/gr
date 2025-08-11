shader_type canvas_item;

uniform float outline_width = 0.02;
uniform vec4 outline_color = vec4(255,255,255,0);

void fragment() {
	vec4 col = texture(TEXTURE, UV);
	vec2 ps = TEXTURE_PIXEL_SIZE;
	float a;
	float maxa = col.a;
	float mina = col.a;

	a = texture(TEXTURE, UV + vec2(0.0, -outline_width) * ps).a;
	maxa = max(a, maxa);
	mina = min(a, mina);

	a = texture(TEXTURE, UV + vec2(0.0, outline_width) * ps).a;
	maxa = max(a, maxa);
	mina = min(a, mina);

	a = texture(TEXTURE, UV + vec2(-outline_width, 0.0) * ps).a;
	maxa = max(a, maxa);
	mina = min(a, mina);

	a = texture(TEXTURE, UV + vec2(outline_width, 0.0) * ps).a;
	maxa = max(a, maxa);
	mina = min(a, mina);
	
	vec4 col2;
	//outline_color.g * (cos(TIME*15.0))
	col2.g = outline_color.g * (sin(TIME*6.0));
	col2.arb = outline_color.arb;
	COLOR = mix(col, col2 * 0.06, maxa - mina);
}