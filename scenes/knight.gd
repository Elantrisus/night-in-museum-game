class_name Player extends CharacterBody3D

signal entered_detection_zone(body)
signal left_detection_zone(body)
signal item_collected(item)

const BASE_SPEED = 5.0
const SPRINT_SPEED = 10.0
const JUMP_VELOCITY = 4.5
const SPRINT_DURATION = 2.0  # Sprint lasts for 3 seconds
const SPRINT_COOLDOWN = 5.0  # Recharge time for sprint

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

var sprint_time_left = SPRINT_DURATION
var sprint_cooldown_left = 0.0
var is_sprinting = false
var ui = null  # Reference to the UI node

func set_ui(ui_node):
	ui = ui_node

func _physics_process(delta):
	# Update sprint timers
	if is_sprinting:
		sprint_time_left -= delta
		if sprint_time_left <= 0:
			is_sprinting = false
			sprint_cooldown_left = SPRINT_COOLDOWN
	else:
		if sprint_time_left < 2:
			sprint_time_left += delta * (SPRINT_DURATION / SPRINT_COOLDOWN)
			sprint_cooldown_left -= delta
		#else:
			#sprint_time_left = SPRINT_DURATION  # Reset sprint time when cooldown is over

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

	# Determine the speed based on whether the sprint key is pressed and available.
	var current_speed = BASE_SPEED
	print(sprint_time_left)
	if Input.is_action_pressed("shift") and sprint_cooldown_left <= 0:
		is_sprinting = true
	else:
		is_sprinting = false
		
	if is_sprinting:
		current_speed = SPRINT_SPEED

	# Move the player.
	velocity = lerp(velocity, direction * current_speed, current_speed * delta)

	move_and_slide()

	# Rotate the player towards movement direction if moving.
	if velocity.length() > 0.0:
		var target_rotation = atan2(-velocity.x, -velocity.z)  # Calculate angle towards velocity direction
		$Rig.rotation.y = lerp_angle($Rig.rotation.y, target_rotation, 10.0 * delta)

	# Update the animation tree parameters.
	var vl = velocity * $Rig.transform.basis
	$AnimationTree.set("parameters/BlendSpace2D/blend_position", Vector2(vl.x, -vl.z) / current_speed)

	# Smooth camera follow.
	$CameraController.position = lerp($CameraController.position, position, smoothstep(0, 0.5, 0.05))

	update_stamina_ui()

func interact(arg):
	print(arg)
	item_collected.emit(arg)
	
func entered_view(arg):
	entered_detection_zone.emit(arg)
	print(arg)

func left_view(arg):
	left_detection_zone.emit(arg)
	print(arg)

func update_stamina_ui():
	var stamina_ratio = sprint_time_left / SPRINT_DURATION
	ui.update_stamina_bar(stamina_ratio * 100)
