extends AudioStreamPlayer2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	play(1)


func toggle_music():
	if playing:
		stop()
	else:
		play(1)
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
