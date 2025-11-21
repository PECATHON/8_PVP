extends Control

@onready var name_input = $LineEdit
@onready var start_btn = $Button

func _ready():
	start_btn.pressed.connect(_on_start)

func _on_start():
	if name_input.text != "":
		# 1. Save Name to Global Data
		GameData.player_name = name_input.text
		
		# 2. Go to the "Hub World" (The one with 3 cubes)
		# REPLACE THIS PATH with your actual Main Scene name!
		get_tree().change_scene_to_file("res://MainScene.tscn") 
	else:
		name_input.placeholder_text = "NAME REQUIRED!!"
