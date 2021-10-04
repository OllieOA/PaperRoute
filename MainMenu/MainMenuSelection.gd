extends Control

onready var menu_clicker = $MenuClick
var first_level = "res://Levels/Level1.tscn"
var credits = "res://MainMenu/Credits.tscn"


func _on_ExitButton_pressed() -> void:
	menu_clicker.play()
	yield(get_tree().create_timer(0.5), "timeout")
	get_tree().quit()


func _on_Start_pressed() -> void:
	menu_clicker.play()
	scene_transition.goto_scene(first_level)


func _on_Credits_pressed() -> void:
	menu_clicker.play()
	scene_transition.goto_scene(credits)
