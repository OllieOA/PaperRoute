extends Area2D

signal paper_delivered

var goal_completed
var character_in_range

onready var prompt = $Prompt
onready var newspaper = $Paper
onready var delivered_text = $DeliverText
onready var ding = $Ding

func _ready() -> void:
	newspaper.hide()
	delivered_text.hide()
	
	
func _process(delta: float) -> void:
	
	if character_in_range and not goal_completed:
		if not prompt.visible:
			prompt.show()
			
		if Input.is_action_just_pressed("activate"):
			if not goal_completed:
				goal_completed = true
				emit_signal("paper_delivered")
				newspaper.show()
				delivered_text.show()
				ding.play()
	else:
		if prompt.visible:
			prompt.hide()


func _on_Goal1_body_entered(body: Node) -> void:
	character_in_range = true


func _on_Goal1_body_exited(body: Node) -> void:
	character_in_range = false
