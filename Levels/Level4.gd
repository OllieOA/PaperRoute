extends Node2D

signal player_crashed
signal lost_papers

onready var newspaper = preload("res://Props/Newspaper.tscn")

onready var character = $Character
onready var trailer = $Trailer
onready var back_wheel = $Character/BackWheel
onready var front_wheel = $Character/FrontWheel
onready var crank = $Character/Crank  # mode 2
onready var front_pedal = $Character/Body/Pedal_front
onready var back_pedal = $Character/Body/Pedal_back
onready var front_calf = $Character/Body/Calf_front
onready var back_calf = $Character/Body/Calf_back
onready var trailer_joint = $Character/TrailerJoint

onready var trailer_body = $Trailer/TrailerFrame
onready var newspaper_spawn_location = $OldMan/SpawnLocation
onready var newspaper_node = $Newspapers
onready var trailer_basket = $Trailer/TrailerBasket
onready var oldman = $OldMan_Chair

# Level control
var character_respawn
var trailer_respawn
var relative_dist
var num_papers_respawn
var winnable
var lost
var talked_to_old_man
var next_level = "res://MainMenu/Credits.tscn"
onready var lose_menu = $CanvasLayer/LoseMenu
onready var timeout_menu = $CanvasLayer/TimeoutMenu
onready var win_noise = $WinNoise

# UI
onready var papers_label = $CanvasLayer/Margin_Text/VBox/NumPapers
onready var delivered_label = $CanvasLayer/Margin_Text/VBox/Delivered
onready var time_label = $CanvasLayer/Margin_Text/VBox/TimeLeft
onready var parallax = $CanvasLayer/Parallax

# Music
onready var music = $GameMusic

# Goals
onready var goal1 = $GoalAreas/Goal1
onready var goal2 = $GoalAreas/Goal2
onready var goal3 = $GoalAreas/Goal3

# Level completion
export var newspapers_for_level = 1
export var deliveries_for_level = 1
export var seconds_for_level = 60.0
var delivered = 0
var level_timer




func _ready() -> void:
	
	oldman.connect("end_game", self, "_end_game")
	papers_label.hide()
	delivered_label.hide()
	time_label.hide()
	
	# Join trailer up
	trailer_joint.node_b = trailer_body.get_path()
#	music.play()
	
	# Set up respawning
	character_respawn = character.global_position
	trailer_respawn = trailer.global_position
	relative_dist = character_respawn - trailer_respawn
	num_papers_respawn = 0
	
	# Level control
	talked_to_old_man = false
	winnable = true
	lost = false
	level_timer = Timer.new()
	add_child(level_timer)
	level_timer.set_one_shot(true)
	level_timer.set_wait_time(seconds_for_level)
	level_timer.connect("timeout", self, "_out_of_time")
	world_parameters.curr_level = 4
	
func _process(delta: float) -> void:
	if not winnable and not lost:
		lost = true
		# Emit signal
		lose_menu.lost_papers = true
	
	var curr_papers = newspaper_node.get_child_count()
	var text_to_set_papers = "Papers: " + str(curr_papers)
	papers_label.text = text_to_set_papers
	
	var text_to_set_deliver = "Delivered: " + str(delivered) + "/" + str(deliveries_for_level)
	delivered_label.text = text_to_set_deliver
	
	var time_left = level_timer.get_time_left()
	var minutes_left = floor(time_left / 60.0)
	var seconds_left = int(time_left) % 60
	var seconds_str = "%02d" % seconds_left
		
	var text_to_set_time = "Time Left: " + str(minutes_left) + ":" + seconds_str
	time_label.text = text_to_set_time
	
	var scroll = Vector2.ZERO
	scroll.x += character.linear_velocity.x
	parallax.scroll_offset += scroll

func _end_game():
	yield(get_tree().create_timer(1.0), "timeout")
	scene_transition.goto_scene(next_level)
