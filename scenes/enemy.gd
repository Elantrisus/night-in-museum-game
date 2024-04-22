extends CharacterBody3D


const SPEED = 0.0
var dir = Vector2(0,1)
var init_pos = Vector3(0,0,0)
func _ready():
	init_pos = position

func _physics_process(delta):
	var direction = (transform.basis * Vector3(dir.x, 0, dir.y)).normalized()
	#if direction:
		#velocity.x = direction.x * SPEED
		#velocity.z = direction.z * SPEED
	#else:
		#velocity.x = move_toward(velocity.x, 0, SPEED)
		#velocity.z = move_toward(velocity.z, 0, SPEED)
	#move_and_slide()
	#print(position)
	#print(init_pos)
	#if abs(position.x - init_pos.z) > 5:
		#dir.x = - dir.x
	#if abs(position.z - init_pos.z) > 5:
		#dir.y = - dir.y


func _on_vision_timer_timeout():
	var overlaps = $VisionArea.get_overlapping_bodies()
	if overlaps.size() > 0:
		for overlap in overlaps:
			if overlap.name == "Knight":
				var playerPosition = overlap.global_transform.origin
				$VisionRayCast.look_at(playerPosition, Vector3.UP)
				$VisionRayCast.force_raycast_update()
				
				if $VisionRayCast.is_colliding():
					var collider = $VisionRayCast.get_collider()
					
					print(collider.name)
					
					if collider.name == "Knight":
						$VisionRayCast.debug_shape_custom_color = Color(174,0,0)
						print("I see you")
					else:
						$VisionRayCast.debug_shape_custom_color = Color(0,255,0)
						print("Where are you?")
			else:
				$VisionRayCast.debug_shape_custom_color = Color(0,255,0)
				print("Where are you?")
				
	
	
