extends Node3D

# Settings you can tweak in Inspector
@export var move_speed: float = 2.0
@export var wander_radius: float = 15.0
@export var pause_time: float = 2.0

var start_position: Vector3
var target_position: Vector3
var is_moving: bool = false
var timer: float = 0.0

func _ready():
	start_position = global_position
	pick_new_target()

func _process(delta):
	if is_moving:
		var direction = global_position.direction_to(target_position)
		global_position += direction * move_speed * delta
		
		var look_target = target_position
		look_target.y = global_position.y
		
		if global_position.distance_to(target_position) > 0.1:
			look_at(look_target, Vector3.UP)
		
		if global_position.distance_to(target_position) < 1.0:
			is_moving = false
			timer = pause_time 
			
	else:
		
		timer -= delta
		if timer <= 0:
			pick_new_target()

func pick_new_target():

	var random_x = randf_range(-wander_radius, wander_radius)
	var random_z = randf_range(-wander_radius, wander_radius)
	
	target_position = start_position + Vector3(random_x, 0, random_z)
	is_moving = true
