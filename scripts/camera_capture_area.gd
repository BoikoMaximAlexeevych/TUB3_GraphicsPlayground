extends Node3D
class_name CamCaptureArea

@export var CapturePosNode: Node3D
@export var toolbox: bool = false

func _on_area_3d_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	if body is DemoCharacter:
		(body as DemoCharacter).Camera.move_to_cinematic_pos(CapturePosNode.global_position, self.toolbox)

func _on_area_3d_body_shape_exited(body_rid, body, body_shape_index, local_shape_index):
	(body as DemoCharacter).Camera.return_to_previous_capture()
