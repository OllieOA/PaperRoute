extends Node2D

onready var dialogue_handler = preload("res://UI/DialogueSystem.tscn")
export var curr_level = 3
var sad_dialogue
var next_level  = "res://Levels/Level4.tscn"
onready var music = $GameMusic

func _ready() -> void:
	sad_dialogue = "res://UI/Dialogue/Level" + str(curr_level) + "/dialogue_" + str(curr_level) + "_sad.json"
#	music.play()
	yield(get_tree().create_timer(2), "timeout")
	world_parameters.sad_noise = true
	play_dialogue(sad_dialogue)

	
func play_dialogue(dialogue_path_to_play):
	get_tree().paused = true
	# Spawn dialogue system
	world_parameters.current_dialogue_completed = false
	var dialogue_instance = dialogue_handler.instance()
	dialogue_instance.get_node("DialogueBox").dialogue_path = dialogue_path_to_play
	dialogue_instance.get_node("DialogueBox").show_portraits = false
	get_tree().get_current_scene().get_node("CanvasLayer/DialogueRenderer").add_child(dialogue_instance)
	
	while not world_parameters.current_dialogue_completed:
		yield(get_tree().create_timer(1.0), "timeout")
	get_tree().paused = false

	scene_transition.goto_scene(next_level)
