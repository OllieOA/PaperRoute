extends Node2D


onready var trailer_joint = $Character/TrailerJoint
onready var trailer_hitch = $Trailer/TrailerHitch

func _ready() -> void:
	trailer_joint.node_b = trailer_hitch.get_path()
