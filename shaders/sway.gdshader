shader_type spatial;
render_mode depth_prepass_alpha, depth_test_default;

uniform sampler2D albedo_texture : source_color;
uniform float darken : hint_range(0., 1.);
uniform vec4 modulate : source_color = vec4(1., 1., 1., 1.);

group_uniforms Sway_params;
// The speed of the horizontal flame movement (sway)
uniform float sway_speed : hint_range(0.1, 5.0) = 1.0;
// How far the texture is displaced horizontally
uniform float sway_strength : hint_range(0.0, 0.05) = 0.01;
// Scales the noise to control the size of the waves/flickers
uniform float noise_scale : hint_range(1.0, 20.0) = 5.0;
// NEW: This uniform will hold the time offset for this specific flame instance.
uniform float time_offset : hint_range(0.0, 100.0) = 0.0;

group_uniforms Backlight_params;
uniform float backlight_strength : hint_range(0.0, 10.0) = 1.5;
uniform vec3 backlight_color : source_color = vec3(1.0, 0.8, 0.6);

// Simple noise function (adapted from common GLSL techniques)
float noise1(vec2 p, float t) { // Pass the time 't' as an argument
    // We use the passed-in time 't' instead of the global TIME
    float n = sin(p.x * 2.0 + t * sway_speed) * 0.5;
    n += sin(p.y * 5.0 + t * sway_speed * 1.5) * 0.3;
    return n;
}


void fragment() {
    vec4 tex = texture(albedo_texture, UV);

	// 1. Calculate the INSTANCE TIME: TIME + offset
    float instance_time = TIME + time_offset;
    
    vec2 distorted_uv = UV;

    // 2. Call the noise function with the instance-specific time
    float displacement = noise1(UV * noise_scale, instance_time) * sway_strength;

    // 3. Apply the displacement
    distorted_uv.x += displacement;

    // 4. Sample the original texture
    vec4 color = texture(albedo_texture, distorted_uv);
    ALBEDO = (color.rgb) * modulate.xyz * (1. - darken);
    ALPHA = color.a;
	
	if (color.a < 0.1)
	{
		//discard;
	}
}

void light()
{
	float NdotL = dot(NORMAL, LIGHT);

    // Light hitting the back side
    float back = max(-NdotL, 0.0);

    // Add backlight contribution
    DIFFUSE_LIGHT += back * backlight_strength * backlight_color * ATTENUATION;
}