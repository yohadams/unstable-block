extends Node2D

var wooden_block_scene = load("res://WoodenBlock.tscn")
var sob = load("res://SOUND/sob.wav")

var camera_move = 128
var wooden_block_stack = [];

var next_block_code = 0 
var last_bg_position = -400
var can_add_another_block = true
 
func generate_bolock(camera_position, fake_position, fake_velocity): 
	print($MainCam/WoodenBlockFake.position)
	var rand = RandomNumberGenerator.new()
	var wooden_block = wooden_block_scene.instance()
	wooden_block.current_code = next_block_code
	rand.randomize()
	next_block_code = rand.randf_range(0, 26)
	$MainCam/WoodenBlockFake.current_code = next_block_code
	wooden_block.position.x = fake_position.x + 300
	wooden_block.position.y = camera_position.y - 250
	wooden_block.velocity = Vector2(fake_velocity.x, 0);
	print(wooden_block.position, wooden_block.velocity)
	wooden_block_stack.push_front(wooden_block)
	add_child(wooden_block)

var camera_start_position = 0
func _ready():
	var screen_size = get_viewport().get_visible_rect().size
	camera_start_position = $MainCam.position.y
	
	

	
func _input(event):
	if event.is_action_pressed("ui_down") || event is InputEventScreenTouch:
		if can_add_another_block:
			can_add_another_block = false
			$MainCam/WoodenBlockFake.visible = false
			generate_bolock($MainCam.position, $MainCam/WoodenBlockFake.position, $MainCam/WoodenBlockFake.velocity)
			if wooden_block_stack.size() >= 3:
				$MainCam.position.y -= 160
				$BLACK.position.y -= 160
				$Wall.position.y -= 160
				$Wall2.position.y -= 160
			print('$WoodenBlockFake.position.y', $MainCam/WoodenBlockFake.position.y)
			print('$MainCam.position.y', $MainCam.position.y)
			add_next_bg_up()
			yield(get_tree().create_timer(1.5), "timeout")
			if wooden_block_stack.size() == 1:
				$KillFloor.position.y = $KillFloor.position.y - 30
			else:
				$KillFloor.position.y = $KillFloor.position.y - 150
			$KillWall2/CollisionShape2D.shape.extents = Vector2($KillWall/CollisionShape2D.shape.extents.x, $KillWall/CollisionShape2D.shape.extents.y+160)
			$KillWall/CollisionShape2D.shape.extents = Vector2($KillWall/CollisionShape2D.shape.extents.x, $KillWall/CollisionShape2D.shape.extents.y+160)
			can_add_another_block = true
			$MainCam/WoodenBlockFake.visible = true
		
func add_next_bg_up():
	var bg = $BG2.duplicate();
	last_bg_position -= 800
	bg.position.y = last_bg_position
	add_child(bg)
	move_child(bg, 1)

func _on_KillWall_body_entered(body):
	process_kill(body)

func _on_KillFloor_body_entered(body):
	process_kill(body)

func kill_all_wooden_block():
	for block in wooden_block_stack:
		block.queue_free()

func process_kill(body):
	if wooden_block_stack.size() >= 1:
		if body == wooden_block_stack[0]:
			kill_all_wooden_block()
			can_add_another_block = false
			$MainCam/WoodenBlockFake.visible = false
			$BG2.visible = false
			$EndGame.position.y = $MainCam.position.y - 300
			$MainCam/WoodenBlockFake.speed = 0
			$MainCam/WoodenBlockFake.velocity = Vector2(0,0)
			var bb_code = $EndGame/SCORE_COUNT.bbcode_text
			$EndGame/SCORE_COUNT.bbcode_text = bb_code.replace('x', str(wooden_block_stack.size()*100))
			$MainCam/WoodenBlockFake.visible = false
			$EndGame.visible = true
			$Sound.is_playing()
			$Sound.stream = sob
			$Sound.play()
