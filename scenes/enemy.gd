extends CharacterBody3D


const SPEED = 0.0
var dir = Vector2(0,1)
var init_pos = Vector3(0,0,0)
var player_body = null
func _ready():
	init_pos = position
	
signal game_over(body)
	
@onready var detection = $Detection

func _physics_process(delta):
	var direction = (transform.basis * Vector3(dir.x, 0, dir.y)).normalized()

func lost_sight():
	$VisionRayCast.debug_shape_custom_color = Color(0,255,0)
	if player_body != null:
		player_body.left_view("I ran away")
		player_body = null
		detection.exited_sight()

func caught_sight(collider):
	print(collider.name)
	
	if collider.has_method("entered_view") and collider.has_method("left_view") and player_body == null:
		$VisionRayCast.debug_shape_custom_color = Color(174,0,0)
		collider.entered_view("I am seen")
		player_body = collider
		detection.distance = global_transform.origin.distance_to(collider.global_transform.origin)
		detection.entered_sight()

func _on_vision_timer_timeout():
	var overlaps = $VisionArea.get_overlapping_bodies()
	var player_detected = false
	if overlaps.size() > 0:
		for overlap in overlaps:
			if overlap.name == "Knight":
				var playerPosition = overlap.global_transform.origin
				$VisionRayCast.look_at(playerPosition, Vector3.UP)
				$VisionRayCast.force_raycast_update()
				
				if $VisionRayCast.is_colliding():
					var collider = $VisionRayCast.get_collider()
					caught_sight(collider)
					player_detected = true
	if not player_detected:
		lost_sight()
				
	


func _on_detection_detection_timeout():
	game_over.emit(self)
