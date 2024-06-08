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
	timer.start(60*3)
	player.set_ui(ui)
	ui.initialize_icons(ITEMS_TO_FIND)
	var artifacts = $artifacts.get_children()
	var locations = $locations.get_children()
	
	if artifacts.size() > locations.size():
		print("Not enough locations for all artifacts")
		return
	
	randomize()  # Seed the random number generator
	
	var available_locations = locations.duplicate()  # Copy the locations array
	
	for artifact in artifacts:
		var index = randi() % available_locations.size()  # Get a random index
		var location = available_locations[index]  # Get the location at the random index
		available_locations.erase(index)  # Remove the location from the array
		
		# Move the artifact to the location
		artifact.transform.origin = location.transform.origin
		print(artifact, " to ", location)

		# Optionally, if you want to set the artifact as a child of the location
		#artifact.get_parent().remove_child(artifact)
		#location.add_child(artifact)

	print("Artifacts have been assigned to locations")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	ui._update_timer(timer.time_left)
	#var artifacts = $artifacts.get_children()
	#var locations = $locations.get_children()
	#for artifact in artifacts:
		#print(artifact.transform.origin)
	#for artifact in locations:
		#print(artifact)


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
