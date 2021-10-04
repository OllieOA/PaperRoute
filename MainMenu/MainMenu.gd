extends Node2D

onready var splash_text = $SplashText
onready var time_dilation = $TimeDilation
onready var pulse_up = $PulseUp
onready var second_pulse_up = $PulseUp2
onready var main_menu_selections = $MainMenu_Selections
onready var tween_values_1 = [0.9, 1.1]
onready var tween_values_2 = [0.9, 1.1]
onready var main_music = $MainMenuMusic

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	main_music.play()
	main_menu_selections.show()
