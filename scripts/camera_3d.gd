extends Camera3D

const ACCELERATION: float = 30.
const MAX_SPEED: float = 80.

var angular_speed: float
var rot_angle: float
var move_speed: float

func _process(delta):
	
	var vertical_input = (int(Input.is_action_pressed("Ascend")) - int(Input.is_action_pressed("Descend")))* delta * 5	
	
	var angular_input = int(Input.is_action_pressed("ui_left")) - int(Input.is_action_pressed("ui_right"))
	angular_speed += angular_input * delta * 5
	rot_angle += angular_speed * delta
	if(not Input.is_action_pressed("ui_left") and not Input.is_action_pressed("ui_right")):
		angular_speed = move_toward(angular_speed, 0., 0.1)
	
	var move_input = int(Input.is_action_pressed("ui_up")) - int(Input.is_action_pressed("ui_down"))
	move_speed -= ACCELERATION * delta * move_input
	move_speed = clamp(move_speed, -MAX_SPEED, MAX_SPEED)
	var direction = Vector2(0., 1.).rotated(-rot_angle) * move_speed * delta
	
	
	self.position.x += direction.x
	self.position.z += direction.y
	
	if(move_input == 0):
		move_speed = move_toward(move_speed, 0., 0.3)
	
	self.rotation.y = rot_angle
	
	
