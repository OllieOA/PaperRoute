extends RigidBody2D


onready var sound_list = [
	"res://Sound/lost_paper_1.ogg", 
	"res://Sound/lost_paper_2.ogg", 
	"res://Sound/lost_paper_3.ogg"
	]
onready var audio_player = $DestoryPlayer
var destroying

func _ready() -> void:
	destroying = false


func _on_Newspaper_body_entered(body: Node) -> void:
	if body.is_in_group("ground") and not destroying:
		destroying = true
		var random_choice = randi() % len(sound_list)
		var sound_to_play = sound_list[random_choice]
		audio_player.stream = load(sound_to_play)
		audio_player.play()
		
		var timer = Timer.new()
		self.add_child(timer)
		timer.connect("timeout", self, "queue_free")
		timer.set_wait_time(0.2)
		timer.start()
