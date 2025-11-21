extends CharacterBody3D


const FORWARD_SPEED = 15.0
const SIDE_SPEED = 8.0
const LANE_DISTANCE = 3.0


var time_passed = 0.0
const HOVER_SPEED = 2.0
const HOVER_AMPLITUDE = 0.5
const BASE_HEIGHT = 1.0


@onready var visuals = $CarpetVisuals
@export var tilt_amount: float = 1
func _physics_process(delta):
	
	var input_dir = Input.get_axis("ui_left", "ui_right")
	var move_fwd = Input.get_axis("ui_up", "ui_down")
	if input_dir:
		velocity.x = input_dir * SIDE_SPEED
	else:
		
		velocity.x = move_toward(velocity.x, 0, SIDE_SPEED)
	if move_fwd: 
		velocity.z = move_fwd * FORWARD_SPEED
	else:
		
		velocity.z = move_toward(velocity.z, 0, FORWARD_SPEED)
	if visuals:
		
		var target_rot = -velocity.x * tilt_amount 
		var target_rot_z = -velocity.x * tilt_amount * .01
		
		visuals.rotation.y = lerp_angle(visuals.rotation.y, target_rot, delta * 5.0)
		visuals.rotation.z = lerp_angle(visuals.rotation.z, target_rot, delta * 5.0)

	move_and_slide()

func _process(delta):
	# --- 3. VISUAL HOVER (Y) ---
	# We do this in _process because it's just a visual effect, not physics
	time_passed += delta
	
	# Calculate the new Y position relative to the Player parent
	var new_y = BASE_HEIGHT + (1 + sin(time_passed * HOVER_SPEED)) * HOVER_AMPLITUDE
	
	# Apply ONLY to the visual mesh, so the actual hitbox doesn't jitter
	visuals.position.y = new_y
