extends RigidBody2D

var A = load("res://IMAGES/ALPHABET/A.png")
var B = load("res://IMAGES/ALPHABET/B.png")
var C = load("res://IMAGES/ALPHABET/C.png")
var D = load("res://IMAGES/ALPHABET/D.png")
var E = load("res://IMAGES/ALPHABET/E.png")
var F = load("res://IMAGES/ALPHABET/F.png")
var G = load("res://IMAGES/ALPHABET/G.png")
var H = load("res://IMAGES/ALPHABET/H.png")
var I = load("res://IMAGES/ALPHABET/I.png")
var J = load("res://IMAGES/ALPHABET/J.png")
var K = load("res://IMAGES/ALPHABET/K.png")
var L = load("res://IMAGES/ALPHABET/L.png")
var M = load("res://IMAGES/ALPHABET/M.png")
var N = load("res://IMAGES/ALPHABET/N.png")
var O = load("res://IMAGES/ALPHABET/O.png")
var P = load("res://IMAGES/ALPHABET/P.png")
var Q = load("res://IMAGES/ALPHABET/Q.png")
var R = load("res://IMAGES/ALPHABET/R.png")
var S = load("res://IMAGES/ALPHABET/S.png")
var T = load("res://IMAGES/ALPHABET/T.png")
var U = load("res://IMAGES/ALPHABET/U.png")
var V = load("res://IMAGES/ALPHABET/V.png")
var W = load("res://IMAGES/ALPHABET/W.png")
var X = load("res://IMAGES/ALPHABET/X.png")
var Y = load("res://IMAGES/ALPHABET/Y.png")
var Z = load("res://IMAGES/ALPHABET/Z.png")

var buh = load("res://SOUND/buh.wav")
var brzyh = load("res://SOUND/brzyh.wav")
var bah = load("res://SOUND/bah.wav")

var sound_array = [buh, brzyh, bah]
var image_array = [A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z]
export var velocity = Vector2()
export var current_code = 0
var sound_played = true


func _ready():
	set_contact_monitor(true)
	connect("body_enter",self,"_on_body_enter")
	$Sprite.texture = image_array[current_code];
	print('faling velocity', velocity)
	set_applied_force(velocity)



func _on_WoodenBlock_body_entered(body):
	var rand = RandomNumberGenerator.new()
	rand.randomize()
	var sound_index = rand.randf_range(0, 3)
	if sound_played:
		if body is StaticBody2D || body is RigidBody2D:
			$Sound.is_playing()
			$Sound.stream = sound_array[sound_index]
			$Sound.play()
			sound_played = false
			
