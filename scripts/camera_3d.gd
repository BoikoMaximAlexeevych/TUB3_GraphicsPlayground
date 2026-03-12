extends Camera3D

var previous_input: Vector2
var dif: float

func _process(delta):
	var input = Vector2(int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left")), 
	int(Input.is_action_pressed("ui_down")) - int(Input.is_action_pressed("ui_up"))) * delta * 10
	
	var vertical_input = (int(Input.is_action_pressed("Ascend")) - int(Input.is_action_pressed("Descend")))* delta * 5	
	
	if input != previous_input:
		dif = sign(input.angle_to(previous_input)) * (input - previous_input).length()
		print("input changed: ", dif)
		previous_input = input

	self.rotation.y = lerp(self.rotation.y, dif, 0.1)
	
	self.position += Vector3(input.x, vertical_input, input.y)
	
