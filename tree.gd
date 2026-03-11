extends Sprite3D
func _ready():
	# Check if the material is a ShaderMaterial
	if material_override is ShaderMaterial:
		# Generate a random float between 0.0 and 100.0
		# This acts as the unique starting point in time for the noise cycle.
		var random_offset = randf() * 100.0
		
		# Set the uniform parameter in the shader
		(material_override as ShaderMaterial).set_shader_parameter("time_offset", random_offset)
		(material_override as ShaderMaterial).set_shader_parameter("albedo_texture", self.texture)
