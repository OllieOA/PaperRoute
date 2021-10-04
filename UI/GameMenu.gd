extends Control

onready var sfx_bus_id = AudioServer.get_bus_index("Master")
onready var music_bus_id = AudioServer.get_bus_index("Music")
onready var menu_clicker = $MenuClick

var base_sfx_bus_vol
var base_music_bus_vol
var sfx_modifier
var music_modifier

func _ready() -> void:
	self.hide()
	
	sfx_modifier = 1.0
	music_modifier = 1.0
	base_sfx_bus_vol = AudioServer.get_bus_volume_db(sfx_bus_id)
	base_music_bus_vol = AudioServer.get_bus_volume_db(music_bus_id)
	

# Called when the node enters the scene tree for the first time.
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("GameMenu") and not self.visible:
		self.show()
		get_tree().paused = true
	elif event.is_action_pressed("GameMenu") and self.visible:
		self.hide()
		get_tree().paused = false

func _on_ExitButton_pressed() -> void:
	menu_clicker.play()
	yield(get_tree().create_timer(0.5), "timeout")
	get_tree().quit()


func _on_CloseMenu_pressed() -> void:
	menu_clicker.play()
	self.hide()
	get_tree().paused = false


func _on_ToggleMusic_pressed() -> void:
	menu_clicker.play()
	yield(get_tree().create_timer(0.2), "timeout")
	AudioServer.set_bus_mute(music_bus_id, not AudioServer.is_bus_mute(music_bus_id))
	
	
func _on_ToggleSFX_pressed() -> void:
	menu_clicker.play()
	yield(get_tree().create_timer(0.2), "timeout")
	AudioServer.set_bus_mute(sfx_bus_id, not AudioServer.is_bus_mute(sfx_bus_id))


func _on_RestartLevel_pressed() -> void:
	menu_clicker.play()
	yield(get_tree().create_timer(0.5), "timeout")
	get_tree().reload_current_scene()
	self.hide()
	get_tree().paused = false
