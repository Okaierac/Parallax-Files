extends Sprite2D

var ready_to_tp := false
var interacted := false

@onready var interactable: Area2D = $Interactable
@onready var timer: Timer = $Timer

func _ready() -> void:
	interactable.interact = _on_interact

func _on_interact():
	if not interacted:
		if GlobalVar.TalkedtoWizard == 2:
			queue_free()
		elif GlobalVar.TalkedtoWizard == 3:
			DialogueManager.show_example_dialogue_balloon(load("res://dialogues/Go TO WIzard.dialogue"), "start")
		interacted = true
		timer.start()
		return

func _on_timer_timeout() -> void:
	interacted = false
