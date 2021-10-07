extends Control

onready var menu_clicker = $MenuClick
onready var level = get_tree().get_current_scene()
var timed_out
var timed_out_latch


func _ready() -> void:
	self.hide()
	timed_out = false
	timed_out_latch = true
	
func _process(delta: float) -> void:
	if timed_out and timed_out_latch:
		timed_out_latch = false
		_show_self()


func _show_self() -> void:
	self.show()
	get_tree().paused = true


func _on_ExitButton_pressed() -> void:
	menu_clicker.play()
	yield(get_tree().create_timer(0.5), "timeout")
	get_tree().quit()


func _on_RestartLevel_pressed() -> void:
	menu_clicker.play()
	var curr_scene = "res://Levels/Level" + str(world_parameters.curr_level) + ".tscn"
	scene_transition.goto_scene(curr_scene)
	get_tree().paused = false
