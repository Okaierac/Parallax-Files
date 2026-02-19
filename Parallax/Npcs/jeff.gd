extends CharacterBody2D
var ready_to_tp := false
@onready var interactable: Area2D = $Interactable
@onready var label: Label = $Label


func _ready() -> void:
	interactable.interact = _on_interact

func _on_interact():
	DialogueManager.show_example_dialogue_balloon(load("res://dialogues/tp.dialogue"), "start")
	var ready_to_tp = true
	if ready_to_tp == true:
		get_tree().change_scene_to_file("res://Scenes/side_main.tscn")
	return
