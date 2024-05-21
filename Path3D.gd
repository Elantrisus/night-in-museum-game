extends Path3D


# Called when the node enters the scene tree for the first time.
func _ready():
	flatten_path()

func flatten_path():
	var curve = self.curve
	if curve == null:
		return
	
	for i in range(curve.get_point_count()):
		var point = curve.get_point_position(i)
		point.y = 0 # Flatten the Y component
		curve.set_point_position(i, point)

		var tilt = 0
		var in_control = curve.get_point_in(i)
		var out_control = curve.get_point_out(i)

		in_control.y = 0 # Flatten the Y component of the in-control point
		out_control.y = 0 # Flatten the Y component of the out-control point

		curve.set_point_in(i, in_control)
		curve.set_point_out(i, out_control)
		curve.set_point_tilt(i, tilt) # Ensure no rotation

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
