extends CharacterBody3D

# Settings
const FORWARD_SPEED = 15.0
const SIDE_SPEED = 8.0
const LANE_DISTANCE = 3.0 # How far apart the lanes are

# Hover Settings
var time_passed = 0.0
const HOVER_SPEED = 2.0
const HOVER_AMPLITUDE = 0.2
const BASE_HEIGHT = 1.0

# Child Reference
@onready var visuals = $CarpetVisuals

func _physics_process(delta):
	# --- 1. AUTOMATIC FORWARD MOVEMENT (Z) ---
	#velocity.z = -FORWARD_SPEED
	
	# --- 2. PLAYER CONTROLLED SIDE MOVEMENT (X) ---
	# Gets a value of -1 (Left), 0 (None), or 1 (Right)
	var input_dir = Input.get_axis("ui_left", "ui_right")
	var move_fwd = Input.get_axis("ui_up", "ui_down")
	if input_dir:
		velocity.x = input_dir * SIDE_SPEED
	else:
		# Friction/Stop smoothly if no key is pressed
		velocity.x = move_toward(velocity.x, 0, SIDE_SPEED)
	if move_fwd: 
		velocity.z = move_fwd * FORWARD_SPEED
	else:
		# Friction/Stop smoothly if no key is pressed
		velocity.z = move_toward(velocity.z, 0, FORWARD_SPEED)

	# Apply the movement
	move_and_slide()

func _process(delta):
	# --- 3. VISUAL HOVER (Y) ---
	# We do this in _process because it's just a visual effect, not physics
	time_passed += delta
	
	# Calculate the new Y position relative to the Player parent
	var new_y = BASE_HEIGHT + sin(time_passed * HOVER_SPEED) * HOVER_AMPLITUDE
	
	# Apply ONLY to the visual mesh, so the actual hitbox doesn't jitter
	visuals.position.y = new_y
