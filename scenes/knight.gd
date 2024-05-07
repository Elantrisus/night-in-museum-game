

class_name Player extends CharacterBody3D

signal entered_detection_zone(body)
signal left_detection_zone(body)
signal item_collected(item)

const SPEED = 7.0
const JUMP_VELOCITY = 4.5

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	#if direction:
		#velocity.x = direction.x * SPEED
		#velocity.z = direction.z * SPEED
	#else:
		#velocity.x = move_toward(velocity.x, 0, SPEED)
		#velocity.z = move_toward(velocity.z, 0, SPEED)
	velocity = lerp(velocity, direction*SPEED, SPEED*delta)

	move_and_slide()
	
	if velocity.length() > 0.0:
		var target_rotation = atan2(-velocity.x, -velocity.z)  # Calculate angle towards velocity direction
		$Rig.rotation.y = lerp_angle($Rig.rotation.y, target_rotation, 10.0 * delta)
	var vl = velocity * $Rig.transform.basis
	$AnimationTree.set("parameters/BlendSpace2D/blend_position",Vector2(vl.x,-vl.z)/ SPEED)
	$CameraController.position = lerp($CameraController.position, position, smoothstep(0,0.5,0.05))


func interact(arg):
	print(arg)
	item_collected.emit(arg)
	
func entered_view(arg):
	entered_detection_zone.emit(arg)
	print(arg)

func left_view(arg):
	left_detection_zone.emit(arg)
	print(arg)
