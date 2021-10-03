extends Sprite


const VELEOCITY = -1.5
var g_texture_height = 0

func _ready():
	g_texture_height = texture.get_size().y * scale.y
	
func _process(delta):
	position.y += VELEOCITY
	_attempt_reposition()
	
func _attempt_reposition():
	if position.y < -g_texture_height:
		position.y += 2 * g_texture_height
