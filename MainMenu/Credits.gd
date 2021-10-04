extends Node2D


onready var second_pulse_up = $PulseUp2
onready var credits_selection = $CreditsSelection
onready var main_music = $MainMenuMusic

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	credits_selection.show()
