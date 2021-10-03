extends Node2D


var woho = load("res://SOUND/woho.wav")

func _ready():
	pass # Replace with function body.

func _on_START_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		print('start click')
		if !event.pressed:
			$Sound.is_playing()
			$Sound.stream = woho
			$Sound.play()
			yield(get_tree().create_timer(0.5), "timeout")
			get_tree().change_scene("res://GAME.tscn")

func letter_wobble_smooth(letter, flag, offset):
	for i in range(offset):
		if flag: 
			letter.position.x += 1
		else:
			letter.position.x -= 1
		yield(get_tree().create_timer(0.05), "timeout")
			
func letter_wobble(letter, offset):
	letter_wobble_smooth(letter, false, offset)
	yield(get_tree().create_timer(0.3), "timeout")
	letter_wobble_smooth(letter, true, offset*2)
	yield(get_tree().create_timer(0.6), "timeout")
	letter_wobble_smooth(letter, false, offset)
	yield(get_tree().create_timer(0.3), "timeout") 

var mouse_on_start_flag = false

func _on_START_mouse_entered():
	mouse_on_start_flag = true
	while mouse_on_start_flag:
		for letter in $START.get_children():
			if mouse_on_start_flag:
				letter_wobble(letter, 6)
				yield(get_tree().create_timer(0.3), "timeout") 


func _on_START_mouse_exited():
	mouse_on_start_flag = false


var mouse_on_mute_flag = false

func _on_MUTE_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if !event.pressed:
			$"/root/BackgroundMusic".toggle_music()
			
func _on_MUTE_mouse_entered():
	mouse_on_mute_flag = true
	while mouse_on_mute_flag:
		for letter in $MUTE.get_children():
			if mouse_on_mute_flag:
				letter_wobble(letter, 6)
				yield(get_tree().create_timer(0.3), "timeout") 


func _on_MUTE_mouse_exited():
	mouse_on_mute_flag = false
