extends Node3D

class_name Game

@export var player: Player
@export var ui: Ui

@onready var timer = $Timer
@onready var game_over_screen = preload("res://scenes/menu/game_over.tscn")
@onready var success_screen = preload("res://scenes/menu/success.tscn")

const ITEMS_TO_FIND = 3
var found_items_count = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	timer.start(60*1.5)
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


func _on_timer_timeout():
	get_tree().change_scene_to_packed(game_over_screen)


func _on_knight_item_collected(item):
	ui.add_object(item)
	found_items_count += 1
	if found_items_count >= ITEMS_TO_FIND:
		get_tree().change_scene_to_packed(success_screen)
