extends Node2D

signal spawn_papers

# This old man is basically just a dialogue system

var player_in_range
var first_dialogue_finished
var dialogue_currently_playing
export var curr_level = 0

onready var prompt_player = $Prompt
onready var dialogue_handler = preload("res://UI/DialogueSystem.tscn")
onready var gate = get_tree().get_current_scene().get_node("GroundTiles/InvisibleGate")

var one_shot_dialogue
var repeat_dialogue

func _ready() -> void:
	first_dialogue_finished = false
	one_shot_dialogue = "res://UI/Dialogue/Level" + str(curr_level) + "/dialogue_" + str(curr_level) + "_one_shot.json"
	repeat_dialogue = "res://UI/Dialogue/Level" + str(curr_level) + "/dialogue_" + str(curr_level) + "_repeat.json"
	print(gate.get_name())

func _process(delta: float) -> void:
	if player_in_range:
		if not prompt_player.visible:
			prompt_player.show()
		if Input.is_action_just_pressed("activate"):
			if not first_dialogue_finished and not dialogue_currently_playing:
				dialogue_currently_playing = true
				gate.queue_free()
				play_dialogue(one_shot_dialogue)
				first_dialogue_finished = true
			else:
				dialogue_currently_playing = true
				play_dialogue(repeat_dialogue)
	else:
		if prompt_player.visible:
			prompt_player.hide()


func play_dialogue(dialogue_path_to_play):
	get_tree().paused = true
	# Spawn dialogue system
	world_parameters.current_dialogue_completed = false
	var dialogue_instance = dialogue_handler.instance()
	dialogue_instance.get_node("DialogueBox").dialogue_path = dialogue_path_to_play
	get_tree().get_current_scene().get_node("CanvasLayer/DialogueRenderer").add_child(dialogue_instance)
	
	while not world_parameters.current_dialogue_completed:
		yield(get_tree().create_timer(0.1), "timeout")
	get_tree().paused = false

	if "one_shot" in dialogue_path_to_play:
		emit_signal("spawn_papers")
		first_dialogue_finished = true
		
	dialogue_currently_playing = false


func _on_Dialogue_Checker_body_entered(body: Node) -> void:
	player_in_range = true


func _on_Dialogue_Checker_body_exited(body: Node) -> void:
	player_in_range = false
