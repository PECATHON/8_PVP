extends Camera3D

# Assign your Player node here in the Inspector
@export var player: Node3D

@export var offset: Vector3 = Vector3(0, 8, 12)


@export var smooth_speed: float = 5.0

func _process(delta):
	if !player: return
	

	var target_pos = player.global_position + offset

	global_position.z = target_pos.z

	global_position.x = lerp(global_position.x, target_pos.x, smooth_speed * delta)
	global_position.y = lerp(global_position.y, target_pos.y, smooth_speed * delta)
	
	look_at(player.global_position, Vector3.UP)
