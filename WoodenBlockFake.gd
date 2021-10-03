extends KinematicBody2D

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

var wooden_block_scene = load("res://WoodenBlock.tscn")

var image_array = [A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z]

export var current_code = 0
export var speed = 150
export var velocity = Vector2()
var rand = RandomNumberGenerator.new()

func _ready():
	$Sprite.texture = image_array[current_code]
	velocity.x = speed		

func _physics_process(delta):
	$Sprite.texture = image_array[current_code]
	var collision = move_and_collide(velocity * delta)
	if collision:
		if velocity.x == speed:
			velocity.x = -speed
		else:
			velocity.x = speed
