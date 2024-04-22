extends Control

@onready var start_button = $MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer/start_button
@onready var load_button = $MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer/load_button

@onready var start_level = preload("res://scenes/level.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_start_button_button_up():
	get_tree().change_scene_to_packed(start_level)


func _on_load_button_button_down():
	pass # Replace with function body.


func _on_settings_button_button_up():
	pass # Replace with function body.


func _on_exit_button_button_up():
	get_tree().quit()
