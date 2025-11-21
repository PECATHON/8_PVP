extends Area3D

# EXPORT VARIABLE: This lets you drag and drop scenes in the Inspector!
@export_file("*.tscn") var target_scene_path

func _ready():
	# Connect signal safely
	body_entered.connect(_on_body_entered)

func _on_body_entered(body):
	if body.name == "Player":
		print("Teleporting to: " + str(target_scene_path))
		
		# This is the magic line that swaps the level
		# It kills the current scene and loads the new one
		get_tree().change_scene_to_file(target_scene_path)
