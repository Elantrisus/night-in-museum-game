extends Node

@onready var timer = $DetectionTimer
@onready var indicator = $Indicator

signal detection_timeout()

const game_over_threshold = 1 # Adjust the threshold for game over here

var is_seen = false
var timer_value = 0
var distance = 0

func entered_sight():
	print("Entered sight")
	is_seen = true
	#timer.start()

func exited_sight():
	print("Exited sight")
	is_seen = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if is_seen:
		if distance < 5:
			timer_value += delta*3
		else:
			timer_value += delta
	else:
		timer_value -= delta/6
		if timer_value < 0:
			timer_value = 0
	
	# Scale the indicator based on timer value
	var scale_factor = timer_value / game_over_threshold
	indicator.scale.x = scale_factor
	indicator.scale.y = scale_factor
	indicator.scale.z = scale_factor

	# Check if game over condition is met
	if timer_value >= game_over_threshold:
		detection_timeout.emit()



