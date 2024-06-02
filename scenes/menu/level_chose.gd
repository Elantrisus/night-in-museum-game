extends Control

@onready var level1 = $MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer/HBoxContainer/MarginContainer/level1
@onready var level2 = $MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer/HBoxContainer/MarginContainer2/level2

@onready var start_level = preload("res://scenes/level.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass




func _on_level_1_button_up():
	get_tree().change_scene_to_packed(start_level)


func _on_level_2_button_up():
	#get_tree().change_scene_to_packed(start_level)
	pass
