extends Node2D


onready var animator1 = $Hint1/Button1/AnimationPlayer
onready var animator2 = $Hint1/Button2/AnimationPlayer
onready var animator3 = $Hint2/Button1/AnimationPlayer
onready var animator4 = $Hint2/Button2/AnimationPlayer

func _ready() -> void:
	animator1.play("Play")
	animator2.play("Play")
	animator3.play("Play")
	animator4.play("Play")
	
	animator1.playback_speed = 0.4
	animator2.playback_speed = 0.4
	animator3.playback_speed = 0.4
	animator4.playback_speed = 0.4


