extends Node

@onready var world: Node = $World
@onready var levels: Node = $Levels
@onready var settings: Node = $Settings
@onready var credits: Node = $Credits

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	remove_child(world)
	remove_child(levels)
	remove_child(settings)
	remove_child(credits)
