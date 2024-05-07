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
	detection_timer.text = str("%.2f" % value)
