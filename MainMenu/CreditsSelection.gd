extends Control

onready var menu_clicker = $MenuClick
var main_menu = "res://MainMenu/MainMenu.tscn"


func _on_ExitButton_pressed() -> void:
	menu_clicker.play()
	yield(get_tree().create_timer(0.5), "timeout")
	get_tree().quit()


func _on_BackButton_pressed() -> void:
	menu_clicker.play()
	scene_transition.goto_scene(main_menu)
