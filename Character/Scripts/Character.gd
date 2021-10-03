extends RigidBody2D

onready var front_wheel = $FrontWheel
onready var back_wheel = $BackWheel
onready var crank = $Crank
onready var torso = $Body/Torso_front
onready var seat_pos = $Seat
onready var crank_pos = $Crank_Hub
onready var head = $Body/Head
onready var front_pedal = $Body/Pedal_front
onready var front_calf = $Body/Calf_front
onready var back_pedal = $Body/Pedal_back
onready var back_calf = $Body/Calf_back

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
	crank.mass = 1.0
	self.angular_damp = 10.0
	self.mass = 200.0
	
	torso.set_mode(2)
	crank.set_mode(2)
	front_pedal.set_mode(2)
	back_pedal.set_mode(2)
	front_calf.set_mode(2)
	back_calf.set_mode(2)
	

func _physics_process(delta: float) -> void:
	if Input.is_action_pressed("drive_forward"):
		_accelerate(1, delta)
	if Input.is_action_pressed("drive_backward"):
		_accelerate(-1, delta)
	if Input.is_action_pressed("tilt_backward"):
		_tilt(-1, delta)
	if Input.is_action_pressed("tilt_forward"):
		_tilt(1, delta)
		
	
func _integrate_forces(state: Physics2DDirectBodyState) -> void:
	# Spin the pedals
	pass
#	crank.global_rotation = back_wheel.global_rotation
#	crank.global_position = crank_pos.global_position
#	state.angular_velocity = back_wheel.angular_velocity
#
#
#	torso.global_rotation = seat_pos.global_rotation
#	torso.global_position = seat_pos.global_position
#
#	head.angular_velocity = 2.0
	


func _accelerate(direction: int, delta: float) -> void:
	var new_wheel_speed = back_wheel.angular_velocity + direction * wheel_acceleration * delta
	var speed_to_set = clamp(new_wheel_speed, -1 * max_wheel_speed, max_wheel_speed)
	back_wheel.angular_velocity = speed_to_set
	

func _tilt(direction: int, delta: float) -> void:
	var new_tilt_speed = self.angular_velocity + direction * tilt_acceleration * delta
	var speed_to_set = clamp(new_tilt_speed, -1 * max_tilt_speed, max_tilt_speed)
	
	self.angular_velocity = speed_to_set
