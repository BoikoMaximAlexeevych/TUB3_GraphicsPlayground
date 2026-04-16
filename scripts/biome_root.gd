extends Node2D

const num_biomes = 3

@onready var Rect = $ColorRect
@onready var sliders: Array[HSlider] = [$ColorRect/VBoxContainer/HBoxContainer/HSliderB1, 
										$ColorRect/VBoxContainer/HBoxContainer2/HSliderB2, 
										$ColorRect/VBoxContainer/HBoxContainer3/HSliderB3]
@onready var pickers: Array[ColorPicker] = [$ColorRect/VBoxContainer2/VBoxContainer/ColorPickerB1, 
											$ColorRect/VBoxContainer2/VBoxContainer2/ColorPickerB2, 
											$ColorRect/VBoxContainer2/VBoxContainer3/ColorPickerB3]
											

func _ready():
	for i in range(num_biomes):
		sliders[i].value = (Rect.material as ShaderMaterial).get_shader_parameter("Biome"+str(i+1)+"Threshold")
		pickers[i].color = (Rect.material as ShaderMaterial).get_shader_parameter("Biome"+str(i+1)+"Colour")
		
func _on_h_slider_b_1_value_changed(value):
	(Rect.material as ShaderMaterial).set_shader_parameter("Biome1Threshold", value)



func _on_h_slider_b_2_value_changed(value):
	(Rect.material as ShaderMaterial).set_shader_parameter("Biome2Threshold", value)


func _on_h_slider_b_3_value_changed(value):
	(Rect.material as ShaderMaterial).set_shader_parameter("Biome3Threshold", value)


func _on_color_picker_b_1_color_changed(color):
	(Rect.material as ShaderMaterial).set_shader_parameter("Biome1Colour", color)


func _on_color_picker_b_3_color_changed(color):
	(Rect.material as ShaderMaterial).set_shader_parameter("Biome2Colour", color)


func _on_color_picker_b_2_color_changed(color):
	(Rect.material as ShaderMaterial).set_shader_parameter("Biome3Colour", color)
