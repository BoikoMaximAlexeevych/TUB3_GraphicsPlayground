shader_type spatial;
render_mode shadow_to_opacity, depth_draw_always;

group_uniforms Noise_Textures;
uniform sampler2D noise;
uniform sampler2D noise2;
uniform sampler2D noise3;
uniform sampler2D soil_noise;

group_uniforms Floor_Colours;
uniform vec4 base_color: source_color;
uniform vec4 soil_color2: source_color;
uniform vec4 color2: source_color;
uniform vec4 color3: source_color;
uniform vec4 color4: source_color;

group_uniforms Colour_Thresholds;
uniform float tr1: hint_range(0., 1.);
uniform float tr2: hint_range(0., 1.);
uniform float tr3: hint_range(0., 1.);
uniform float tr_soil: hint_range(0., 1.);

group_uniforms Sway_Parameters;
uniform float sway_speed : hint_range(0.1, 5.0) = 1.0;
uniform float sway_strength : hint_range(0.0, 0.05) = 0.01;
uniform float noise_scale : hint_range(1.0, 20.0) = 5.0;

void vertex() {
	// Called for every vertex the material is visible on.
}

float noise1(vec2 p, float t) 
{ 
    float n = sin(p.x * 2.0 + t * sway_speed) * 0.5;
    n += sin(p.y * 5.0 + t * sway_speed * 1.5) * 0.3;
    return n;
}


vec3 calculate_noise_color(in float n1, in float n2, in float n3, in float s1)
{
	vec3 final_color;
	
	if(n3 >= tr1)
	{
		final_color = color2.xyz;
		
		if(n2 >= tr2)
		{
			final_color = color3.xyz;
		}
		if(n1 >= tr3)
		{
			final_color = color4.xyz;
		}
	}
	else
	{
		final_color = base_color.xyz;
		if(s1 >= tr_soil)
		{
			final_color = soil_color2.xyz;
		}
	}
	
	return final_color;
}

void fragment() {
	float instance_time = TIME;
	float displacement = noise1(UV * noise_scale, instance_time) * sway_strength;
	vec2 displaced_uv = UV + vec2(displacement, 0.);
	
	float n1 = texture(noise, displaced_uv).r;
	float n2 = texture(noise2, displaced_uv).r;
	float n3 = texture(noise3, UV).r;
	float s1 = texture(soil_noise, UV).r;
	
	vec3 col = calculate_noise_color(n1, n2, n3, s1);

	ALBEDO = col;
}

//void light() {
//	// Called for every pixel for every light affecting the material.
//	// Uncomment to replace the default light processing function with this one.
//}
