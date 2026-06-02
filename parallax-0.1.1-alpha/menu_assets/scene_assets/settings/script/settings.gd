extends Node

@onready var display_mode: OptionButton = $"Control/MarginContainer/VBoxContainer/Display Mode"
@onready var volume: HSlider = $Control/MarginContainer/VBoxContainer/Volume
@onready var mute: CheckBox = $Control/MarginContainer/VBoxContainer/Mute

func _ready():
	_load_settings()

func _save_settings() -> void:
	var config = ConfigFile.new()

	config.set_value("display", "mode", display_mode.selected)
	config.set_value("audio", "volume", volume.value)
	config.set_value("audio", "mute", AudioServer.is_bus_mute(0))

	config.save("user://settings.cfg")

func _load_settings():
	var config = ConfigFile.new()
	if config.load("user://settings.cfg") == OK:
		# Display Mode
		var mode = config.get_value("display", "mode", 0)
		display_mode.select(mode)
		_on_resolutions_item_selected(mode)
		# Volume
		var saved_volume = config.get_value("audio", "volume", volume.value)
		volume.value = saved_volume
		AudioServer.set_bus_volume_db(0, saved_volume / 5)
		# Mute
		var saved_mute = config.get_value("audio", "mute", false)
		AudioServer.set_bus_mute(0, saved_mute)
		mute.button_pressed = saved_mute


func _on_go_back_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")


func _on_volume_value_changed(value):
	AudioServer.set_bus_volume_db(0, value / 5)
	_save_settings()


func _on_mute_toggled(toggled_on):
	AudioServer.set_bus_mute(0, toggled_on)
	_save_settings()


func _on_resolutions_item_selected(index):
	match index:
		0:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
		1:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
	_save_settings()
