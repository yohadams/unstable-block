extends Node2D

export var score = 0

func _ready():
	pass # Replace with function body.

func _on_MENU_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		print('menu click')
		if !event.pressed:
			get_tree().change_scene("res://StartScrean.tscn")

func _on_REPEAT_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		print('repeat click', event.pressed)
		if !event.pressed:
			get_tree().reload_current_scene()

func letter_wobble_smooth(letter, flag, offset):
	for i in range(offset):
		if flag: 
			letter.position.y += 1
		else:
			letter.position.y -= 1
		yield(get_tree().create_timer(0.05), "timeout")
			
			
func letter_wobble(letter, offset):
	letter_wobble_smooth(letter, true, offset)
	yield(get_tree().create_timer(0.3), "timeout")
	letter_wobble_smooth(letter, false, offset*2)
	yield(get_tree().create_timer(0.6), "timeout")
	letter_wobble_smooth(letter, true, offset)
	yield(get_tree().create_timer(0.3), "timeout") 

func letter_reset(letter, reset_y):
	letter.position.y = reset_y
	
var mouse_on_repeat_flag = false

func _on_REPEAT_mouse_entered():
	print('repeat on mouse enter')
	mouse_on_repeat_flag = true
	while mouse_on_repeat_flag:
		for letter in $REPEAT.get_children():
			if mouse_on_repeat_flag:
				letter_wobble(letter, 6)
				yield(get_tree().create_timer(0.3), "timeout") 
	

func _on_REPEAT_mouse_exited():
	print('repeat on mouse enter')
	mouse_on_repeat_flag = false

var mouse_on_menu_flag = false

func _on_MENU_mouse_entered():
	print('menu on mouse enter')
	mouse_on_menu_flag = true
	while mouse_on_menu_flag:
		for letter in $MENU.get_children():
			if mouse_on_menu_flag:
				letter_wobble(letter, 6)
				yield(get_tree().create_timer(0.3), "timeout") 

func _on_MENU_mouse_exited():
	print('menu on mouse out')
	mouse_on_menu_flag = false
