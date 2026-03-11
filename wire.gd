extends Sprite3D
var total_time = 0.
var init_pos: Vector3

func _ready():
	init_pos = self.position

func _process(delta):
	total_time += delta
	position = init_pos + Vector3(sin(total_time)*0.5, 0., 1.)
