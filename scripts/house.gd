extends Node3D

@onready var roof = $Roof
@onready var pos_to_set_camera = $CameraPosToDictate.global_position
#((roof.mesh as QuadMesh).material as StandardMaterial3D).albedo_color

func make_roof_transparent() -> void:
	var tween = get_tree().create_tween()
	tween.tween_property(((roof.mesh as QuadMesh).material as StandardMaterial3D), 
						"albedo_color", 
						Color(1.0, 1.0, 1.0, 0.0), 
						.2).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_QUAD)
func make_roof_visible() ->void:
	var tween = get_tree().create_tween()
	tween.tween_property(((roof.mesh as QuadMesh).material as StandardMaterial3D), 
						"albedo_color", 
						Color(1.0, 1.0, 1.0, 1.0), 
						.2).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_QUAD)

func _on_area_3d_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	if body is DemoCharacter:
		make_roof_transparent()

func _on_area_3d_body_shape_exited(body_rid, body, body_shape_index, local_shape_index):
	make_roof_visible()
	
