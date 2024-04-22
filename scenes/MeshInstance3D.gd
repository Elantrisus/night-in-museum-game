extends MeshInstance3D


# Called when the node enters the scene tree for the first time.
func _ready():
	visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	pass


func _on_interact_area_body_entered(body):
	visible = true


func _on_interact_area_body_exited(body):
	visible = false
