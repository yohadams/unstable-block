extends Node2D

var wooden_block_scene = load("res://WoodenBlock.tscn")
var sob = load("res://SOUND/sob.wav")

var camera_move = 128
var wooden_block_stack = [];

var next_block_code = 0 
var last_bg_position = -400
var can_add_another_block = true

func generate_bolock(position, fake_velocity): 
	var rand = RandomNumberGenerator.new()
	var wooden_block = wooden_block_scene.instance()
	wooden_block.current_code = next_block_code
	rand.randomize()
	next_block_code = rand.randf_range(0, 26)
	$WoodenBlockFake.current_code = next_block_code
	wooden_block.position.x = position.x
	wooden_block.position.y = position.y + 20
	wooden_block.velocity = Vector2(fake_velocity.x, 0);
	wooden_block_stack.push_front(wooden_block)
	add_child(wooden_block)

func _ready():
	var screen_size = get_viewport().get_visible_rect().size
	
func _input(event):
	if event.is_action_pressed("ui_down"):
		if can_add_another_block:
			can_add_another_block = false
			$WoodenBlockFake.visible = false
			generate_bolock($WoodenBlockFake.position, $WoodenBlockFake.velocity)
			$WoodenBlockFake.position.y -= camera_move
			$MainCam.position.y -= camera_move
			$BLACK.position.y -= camera_move
			$Wall.position.y -= camera_move
			$Wall2.position.y -= camera_move
			add_next_bg_up()
			yield(get_tree().create_timer(1.5), "timeout")
			if wooden_block_stack.size() == 1:
				$KillFloor.position.y = $KillFloor.position.y - 30
			else:
				$KillFloor.position.y = $KillFloor.position.y - 150
			$KillWall2/CollisionShape2D.shape.extents = Vector2($KillWall/CollisionShape2D.shape.extents.x, $KillWall/CollisionShape2D.shape.extents.y+160)
			$KillWall/CollisionShape2D.shape.extents = Vector2($KillWall/CollisionShape2D.shape.extents.x, $KillWall/CollisionShape2D.shape.extents.y+160)
			can_add_another_block = true
			$WoodenBlockFake.visible = true
		
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
			$WoodenBlockFake.visible = false
			$BG2.visible = false
			$MainCam.position.y = 480
			$WoodenBlockFake.speed = 0
			$WoodenBlockFake.velocity = Vector2(0,0)
			var bb_code = $EndGame/SCORE_COUNT.bbcode_text
			$EndGame/SCORE_COUNT.bbcode_text = bb_code.replace('x', str(wooden_block_stack.size()*100))
			$EndGame.visible = true
			$Sound.is_playing()
			$Sound.stream = sob
			$Sound.play()
