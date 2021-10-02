extends RigidBody2D

onready var front_wheel = $FrontWheel
onready var back_wheel = $BackWheel

var wheel_acceleration = 100.0
var max_wheel_speed = 15.0
var tilt_acceleration = 60.0
var max_tilt_speed = 600.0

func _ready() -> void:
	# Initialise the physics parameters by code
	front_wheel.mass = 30.0
	front_wheel.angular_velocity = 0.0
	back_wheel.mass = 100.0
	back_wheel.angular_velocity = 0.0
	back_wheel.angular_damp = -1.0
	back_wheel.physics_material_override.friction = 4.0
	self.angular_damp = 10.0
	self.mass = 200.0

func _physics_process(delta: float) -> void:
	if Input.is_action_pressed("drive_forward"):
		_accelerate(1, delta)
	if Input.is_action_pressed("drive_backward"):
		_accelerate(-1, delta)
	if Input.is_action_pressed("tilt_backward"):
		_tilt(-1, delta)
	if Input.is_action_pressed("tilt_forward"):
		_tilt(1, delta)


func _accelerate(direction: int, delta: float) -> void:
	var new_wheel_speed = back_wheel.angular_velocity + direction * wheel_acceleration * delta
	var speed_to_set = clamp(new_wheel_speed, -1 * max_wheel_speed, max_wheel_speed)
	back_wheel.angular_velocity = speed_to_set
	

func _tilt(direction: int, delta: float) -> void:
	var new_tilt_speed = self.angular_velocity + direction * tilt_acceleration * delta
	var speed_to_set = clamp(new_tilt_speed, -1 * max_tilt_speed, max_tilt_speed)
	
	self.angular_velocity = speed_to_set
