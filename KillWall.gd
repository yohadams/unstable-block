extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	connect("area_entered", self, "test")
	pass # Replace with function body.




func test(area):
	print('aaaaa')
