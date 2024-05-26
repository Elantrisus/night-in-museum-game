extends Control
class_name Ui

@onready var detection_timer = %DetectionTimer

# Called when the node enters the scene tree for the first time.
func _ready():
	detection_timer.text = "Test label"
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _update_timer(value: float):
	detection_timer.text = time_convert(int(value))

func time_convert(time_in_sec):
	var seconds = time_in_sec%60
	var minutes = (time_in_sec/60)%60
	
	#returns a string with the format "HH:MM:SS"
	return "%02d:%02d" % [minutes, seconds]

func add_object(obj):
	var new_texture = TextureRect.new()
	var texture = load(obj) # Load the texture from the provided path
	new_texture.texture = texture # Set the texture for the TextureRect
	
	# Set stretch mode to keep aspect ratio
	new_texture.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
	
	# Get the original size of the texture
	var original_size = texture.get_size()
	
	# Define the desired vertical size
	var desired_vertical_size = 100.0 # Replace with your desired vertical size in pixels
	
	# Calculate the scale factor
	var scale_factor = desired_vertical_size / original_size.y
	
	# Apply the scale factor to the rect_scale
	new_texture.size = Vector2(scale_factor, scale_factor)
	
	$MarginContainer/GridContainer2/HBoxContainer.add_child(new_texture)
