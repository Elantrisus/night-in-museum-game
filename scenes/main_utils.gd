extends Node3D
 #
#var ray_origin = Vector3()
#var ray_target = Vector3()
#
## Reference to the Camera3D node
#var camera: Camera3D
## Reference to the CameraController script
##
#func _ready():
	#var character = load("res://scenes/knight.tscn")
	#add_child(character)
	## Find the Camera3D node in the player's character
	#camera = $Camera3D
##
#func _physics_process(delta):
	#var mouse_pos = get_viewport().get_mouse_position()
	#
	#ray_origin = camera.project_ray_origin(mouse_pos)
	#print(mouse_pos)
