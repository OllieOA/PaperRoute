extends Node2D

onready var trailer_wheel = $TrailerWheel
onready var trailer_frame = $TrailerFrame
onready var trailer_hitch = $TrailerHitch
onready var trailer_basket = $TrailerBasket

func _ready() -> void:
	trailer_wheel.mass = 30.0
	trailer_frame.mass = 10.0
	trailer_hitch.mass = 1.0
	trailer_basket.mass = 10.0
	
	trailer_basket.angular_damp = 50.0
