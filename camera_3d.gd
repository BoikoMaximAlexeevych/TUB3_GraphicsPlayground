extends Camera3D

func _process(delta):
	var input = Vector2(int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left")), 
	int(Input.is_action_pressed("ui_down")) - int(Input.is_action_pressed("ui_up"))) * delta * 10
	
	var vertical_input = (int(Input.is_action_pressed("Ascend")) - int(Input.is_action_pressed("Descend")))* delta * 5	
	self.position += Vector3(input.x, vertical_input, input.y)
