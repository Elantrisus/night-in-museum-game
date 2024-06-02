extends PathFollow3D

var speed = 5.0 # Speed in units per second
var total_length = 0.0

# Called when the node enters the scene tree for the first time.
func _ready():
	calculate_total_length()
	#set_fixed_process(true)

func calculate_total_length():
	var curve = get_parent().curve
	total_length = curve.get_baked_length()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var distance_traveled = speed * delta
	var current_distance = progress_ratio * total_length
	var new_distance = current_distance + distance_traveled
	
	if new_distance > total_length:
		new_distance = new_distance - total_length # Loop back to the start
	
	progress_ratio = new_distance / total_length
