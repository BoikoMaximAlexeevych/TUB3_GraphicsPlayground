extends Camera3D
class_name DemoCamera
@export var Character: DemoCharacter

enum CameraMode{
	FOLLOW,
	CINEMATIC
}
var Mode: CameraMode = CameraMode.FOLLOW
var target_pos: Vector3

func move_to_cinematic_pos(pos: Vector3, toolbox: bool):
	self.Mode = CameraMode.CINEMATIC
	self.target_pos = pos
	var tween = get_tree().create_tween()
	tween.set_parallel()
	tween.set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_CUBIC)
	tween.tween_property(self, "global_position", pos, 1.)
	tween.tween_property((self.attributes as CameraAttributesPractical), "dof_blur_near_distance", pos.y*0.75, 1.)
	if toolbox:
		tween.tween_property((self.attributes as CameraAttributesPractical), "dof_blur_far_distance", pos.y*0.25, 1.)
	else: 
		tween.tween_property((self.attributes as CameraAttributesPractical), "dof_blur_far_distance", pos.y*2, 1.)
	
func return_to_player():
	self.Mode = CameraMode.FOLLOW

func return_to_previous_capture():
	print(len(Character.Collider.get_overlapping_areas()))
	for area in Character.Collider.get_overlapping_areas():
		if area.get_parent_node_3d() is CamCaptureArea:
			print("STILL HERE")
			move_to_cinematic_pos((area.get_parent() as CamCaptureArea).CapturePosNode.global_position, false)
	if len(Character.Collider.get_overlapping_areas()) == 0:
		self.Mode = CameraMode.FOLLOW

func _process(delta):
	if Mode == CameraMode.FOLLOW:
		self.global_position = lerp(self.global_position, Character.global_position + Vector3(0., 14., 0.), 6*delta)
