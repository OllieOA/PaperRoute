extends Node2D

onready var front_pedal = $Pedal_front
onready var back_pedal = $Pedal_back
onready var calf_front = $Calf_front
onready var calf_back = $Calf_back
onready var thigh_front = $Thigh_front
onready var thigh_back = $Thigh_back
onready var torso = $Torso_front
onready var bicep_front = $Bicep_front
onready var bicep_back = $Bicep_back
onready var forearm_front = $Forearm_front
onready var forearm_back = $Forearm_back
onready var head = $Head

var default_bone_stiffness = 10.0
var pedal_stiffness = 500.0
var torso_stiffness = 5.0
var joint_softness = 0.1
var no_softness = 0.0

func _ready() -> void:
	front_pedal.angular_damp = no_softness
	back_pedal.angular_damp = no_softness
	calf_front.angular_damp = default_bone_stiffness
	calf_back.angular_damp = default_bone_stiffness
	thigh_front.angular_damp = default_bone_stiffness
	thigh_back.angular_damp = default_bone_stiffness
	torso.angular_damp = torso_stiffness
	bicep_front.angular_damp = default_bone_stiffness
	bicep_back.angular_damp = default_bone_stiffness
	forearm_front.angular_damp = default_bone_stiffness
	forearm_back.angular_damp = default_bone_stiffness
	
	torso.gravity_scale = -1
	head.gravity_scale = -2
	
	front_pedal.get_node("Pedal").softness = no_softness
	back_pedal.get_node("Pedal").softness = no_softness
	calf_front.get_node("Ankle").softness = joint_softness
	calf_back.get_node("Ankle").softness = joint_softness
	thigh_front.get_node("Knee").softness = joint_softness
	thigh_back.get_node("Knee").softness = joint_softness
	torso.get_node("FrontHip").softness = joint_softness
	torso.get_node("FrontShoulder").softness = joint_softness
	torso.get_node("BackHip").softness = joint_softness
	torso.get_node("BackShoulder").softness = joint_softness
	bicep_front.get_node("Elbow").softness = joint_softness
	bicep_back.get_node("Elbow").softness = joint_softness
	forearm_front.get_node("Hand").softness = joint_softness
	forearm_back.get_node("Hand").softness = joint_softness
	
