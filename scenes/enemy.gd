extends CharacterBody3D


const SPEED = 2.0
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
