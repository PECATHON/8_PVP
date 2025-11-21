extends Camera3D

# Assign your Player node here in the Inspector
@export var player: Node3D

# Configuration for "Far Away Zoomed Out"
# (x=0, y=8 up, z=12 back)
@export var offset: Vector3 = Vector3(0, 8, 12)

# How "lazy" the camera is on the X/Y axis. 
# Lower = smoother/slower. Higher = snaps instantly.
@export var smooth_speed: float = 5.0

func _process(delta):
	if !player: return
	
	# 1. Calculate the desired target position
	var target_pos = player.global_position + offset
	
	# 2. Handle Forward Movement (Z-Axis)
	# We want to HARD LOCK the Z axis so the player never outruns the camera
	global_position.z = target_pos.z
	
	# 3. Handle Side/Height Movement (X and Y Axis)
	# We LERP (Linear Interpolate) these to make it feel smooth/floaty
	global_position.x = lerp(global_position.x, target_pos.x, smooth_speed * delta)
	global_position.y = lerp(global_position.y, target_pos.y, smooth_speed * delta)
	
	# 4. Make the camera look slightly ahead of the player, not directly down at them
	# Looking at the player's position gives a focused tracking shot
	look_at(player.global_position, Vector3.UP)
