extends CharacterBody3D
class_name DemoCharacter
@export var Camera: Camera3D
@onready var Collider: Area3D = $Area3D

const ACCELERATION: float = 30.
const MAX_SPEED: float = 10.

var angular_speed: float
var rot_angle: float
var move_speed: float

func _physics_process(delta):
	var up_down = int(Input.is_action_pressed("ui_up")) - int(Input.is_action_pressed("ui_down"))
	var left_right = int(Input.is_action_pressed("ui_left")) - int(Input.is_action_pressed("ui_right"))
	self.position -= Vector3(left_right, 0., up_down).normalized()*delta*MAX_SPEED
	
	if(up_down == 0 and left_right == 0):
		move_speed = move_toward(move_speed, 0., 0.3)
	move_and_slide()
