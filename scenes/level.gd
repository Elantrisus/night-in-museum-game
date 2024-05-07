extends Node3D

class_name Game

@export var player: Player
@export var ui: Ui

@onready var timer = $Timer
@onready var game_over_screen = preload("res://scenes/menu/game_over.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	ui._update_timer(timer.time_left)


func _on_knight_entered_detection_zone(body):
	pass


func _on_knight_left_detection_zone(body):
	pass


func _on_enemy_game_over(body):
	get_tree().change_scene_to_packed(game_over_screen)
