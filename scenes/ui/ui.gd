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
	new_texture.set_texture(texture) # Set the texture for the TextureRect
	
	$MarginContainer/VBoxContainer/HBoxContainer.add_child(new_texture)
