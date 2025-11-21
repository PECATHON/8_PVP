extends MeshInstance3D

# Speed of rotation (radians per second)
# 1.0 is roughly 60 degrees per second. 
# Lower this number (e.g. 0.5) for a slower, gentler spin.
@export var rotation_speed: float = 1.0

func _process(delta):
	# Rotate around the Y axis (Up/Down axis)
	rotate_y(rotation_speed * delta)
