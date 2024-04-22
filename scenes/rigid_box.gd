extends RigidBody3D

var interactable = null

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$interact_area.position = position
	$interact_area.rotation = Vector3(0,0,0)
	
	if interactable != null:
		if Input.is_action_just_pressed("e"):
			interactable.interact("Object picked up")
			queue_free()


func _on_interact_area_body_entered(body):
	if body.has_method("interact"):
		interactable = body
		

func _on_interact_area_body_exited(body):
	interactable = null
