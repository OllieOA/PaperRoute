extends NinePatchRect

onready var oldman_voice = $OldMan_voice
onready var player_voice = $Player_voice


# Oldman audio
var oldman_happy = preload("res://UI/Dialogue/Portraits/portrait_OldManHappy.png")
var oldman_neutral = preload("res://UI/Dialogue/Portraits/portrait_OldManNeutral.png")
var oldman_sound1 = preload("res://Sound/Oldman-01.ogg")
var oldman_sound2 = preload("res://Sound/Oldman-02.ogg")
var oldman_sound3 = preload("res://Sound/Oldman-03.ogg")
var oldman_sound4 = preload("res://Sound/Oldman-04.ogg")
var oldman_sound5 = preload("res://Sound/Oldman-05.ogg")

var oldman_sound_list = [
	oldman_sound1,
	oldman_sound2,
	oldman_sound3,
	oldman_sound4,
	oldman_sound5
]

var oldman_portraits = {
	"Happy": oldman_happy,
	"Neutral": oldman_neutral
}

# Player dialogue
var player_happy = preload("res://UI/Dialogue/Portraits/portrait_PlayerHappy.png")
var player_neutral = preload("res://UI/Dialogue/Portraits/portrait_PlayerNeutral.png")
var player_sound1 = preload("res://Sound/Player-01.ogg")
var player_sound2 = preload("res://Sound/Player-02.ogg")
var player_sound3 = preload("res://Sound/Player-03.ogg")
var player_sound4 = preload("res://Sound/Player-04.ogg")
var player_sound5 = preload("res://Sound/Player-05.ogg")

var player_sound_list = [
	player_sound1,
	player_sound2,
	player_sound3,
	player_sound4,
	player_sound5
]

var player_portraits = {
	"Happy": player_happy,
	"Neutral": player_neutral
}

var portraits = {
	"You": player_portraits,
	"Old Man McLudum": oldman_portraits
}

var dialogue_path = ""
var text_speed = 0.02

onready var timer = $Timer
onready var dialogue_name = $Name
onready var dialogue_text = $Text
onready var indicator = $Indicator
onready var portrait = $Portrait

var dialogue
signal dialogue_complete_bool
var phrase_number = 0
var finished = false

func _ready() -> void:
	timer.wait_time = text_speed
	dialogue = get_dialogue()
	assert(dialogue, "Dialogue file missing after reading it!")
	
	next_phrase()

func _process(delta: float) -> void:
	indicator.visible = finished
	if Input.is_action_just_pressed("accept_dialogue"):
		if finished:
			next_phrase()
		else:
			dialogue_text.visible_characters = len(dialogue_text.text)

func get_dialogue() -> Array:
	var f = File.new()
	assert(f.file_exists(dialogue_path), "Dialogue file missing.. sorry!")
	
	f.open(dialogue_path, File.READ)
	var json = f.get_as_text()
	
	var output = parse_json(json)
	
	if typeof(output) == TYPE_ARRAY:
		return output
	else:
		return []

func next_phrase():
	if phrase_number >= len(dialogue):
		world_parameters.current_dialogue_completed = true
		queue_free()
		return
		
	finished = false
	var current_speaker = dialogue[phrase_number]["Name"]
	var random_choice = randi() % 5
	if current_speaker == "Old Man McLudum":
		oldman_voice.stream = oldman_sound_list[random_choice]
		oldman_voice.play()
	elif current_speaker == "You":
		player_voice.stream = player_sound_list[random_choice]
		player_voice.play()
	
	dialogue_name.bbcode_text = "  " + dialogue[phrase_number]["Name"] + ":"
	var dialogue_text_to_show = " " + dialogue[phrase_number]["Text"]
	dialogue_text.bbcode_text = dialogue_text_to_show
	
	dialogue_text.visible_characters = 0
	
	# Figure out portrait to use
	var char_name = dialogue[phrase_number]["Name"]
	var char_emotion = dialogue[phrase_number]["Emotion"]
	var new_texture = portraits[char_name][char_emotion]

	portrait.texture = new_texture
	
	while dialogue_text.visible_characters < len(dialogue_text.text):
		dialogue_text.visible_characters += 1
		
		timer.start()
		yield(timer, "timeout")
	
	finished = true
	phrase_number += 1
	return
		
		
		
		
