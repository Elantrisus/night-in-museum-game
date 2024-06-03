extends Control
class_name Ui

@onready var detection_timer = %DetectionTimer
@onready var icon_container = $MarginContainer/GridContainer2/HBoxContainer
@onready var stamina_bar = $StaminaBar

# Called when the node enters the scene tree for the first time.
func _ready():
	stamina_bar.value = stamina_bar.max_value


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _update_timer(value: float):
	detection_timer.text = time_convert(int(value))

func time_convert(time_in_sec):
	var seconds = time_in_sec % 60
	var minutes = (time_in_sec / 60) % 60
	
	# Returns a string with the format "HH:MM"
	return "%02d:%02d" % [minutes, seconds]

func initialize_icons(count):
	for i in range(count):
		print(i)
		var new_texture = TextureRect.new()
		new_texture.texture = load("res://assets/vase/vase-bw.png") # Load the black and white icon texture
		new_texture.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
		new_texture.size_flags_horizontal = Control.SIZE_FILL
		icon_container.add_child(new_texture)
		

func add_object(obj):
	var texture = load(obj) # Load the texture from the provided path
	
	for child in icon_container.get_children():
		if child.texture == load("res://assets/vase/vase-bw.png"):
			child.texture = texture
			break

func update_stamina_bar(value):
	stamina_bar.value = value
