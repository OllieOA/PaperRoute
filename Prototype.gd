extends Node2D

onready var newspaper = preload("res://Props/Newspaper.tscn")

onready var character = $Character
onready var back_wheel = $Character/BackWheel
onready var trailer_joint = $Character/TrailerJoint
onready var trailer_hitch = $Trailer/TrailerHitch
onready var newspaper_spawn_location = $OldMan/SpawnLocation
onready var newspaper_node = $Newspapers
onready var trailer_basket = $Trailer/TrailerBasket
onready var oldman = $OldMan

# UI
onready var papers_label = $CanvasLayer/Margin_Text/VBox/NumPapers
onready var delivered_label = $CanvasLayer/Margin_Text/VBox/Delivered

# Level completion
export var newspapers_for_level = 6
export var deliveries_for_level = 2
var delivered = 0

func _ready() -> void:
	# Join trailer up
	trailer_joint.node_b = trailer_hitch.get_path()
	oldman.connect("spawn_papers", self, "_spawn_papers")
	
	
func _process(delta: float) -> void:
	var curr_papers = newspaper_node.get_child_count()
	var text_to_set_papers = "Papers: " + str(curr_papers)
	papers_label.text = text_to_set_papers
	
	var text_to_set_deliver = "Delivered: " + str(delivered) + "/" + str(deliveries_for_level)
	delivered_label.text = text_to_set_deliver
	

func _physics_process(delta: float) -> void:
	newspaper_spawn_location.global_position.x = trailer_basket.global_position.x
	newspaper_spawn_location.global_position.y = trailer_basket.global_position.y - 40
	

func _spawn_papers() -> void:
	character.linear_velocity = Vector2.ZERO
	back_wheel.angular_velocity = 0
	for i in range(newspapers_for_level):
		var newspaper_instance = newspaper.instance()
		var horizontal_step = i % 2
		if horizontal_step > 0:
			newspaper_spawn_location.global_position.y = newspaper_spawn_location.global_position.y - 20
			newspaper_spawn_location.global_position.x = newspaper_spawn_location.global_position.x + 10
		else:
			newspaper_spawn_location.global_position.y = newspaper_spawn_location.global_position.y
			newspaper_spawn_location.global_position.x = newspaper_spawn_location.global_position.x - 10
		newspaper_instance.global_position = newspaper_spawn_location.global_position
		newspaper_node.add_child(newspaper_instance)
