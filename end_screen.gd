extends Control

@onready var score_label = $Label
@onready var leaderboard_list = $ItemList
@onready var restart_btn = $Button
@onready var review_label = $ReviewPanel/ReviewText 



func _ready():
	# 1. Show Final Score
	score_label.text = "Final Score: " + str(GameData.current_score)
	
	# 2. Save the Data
	GameData.save_score()
	
	# 3. Display Leaderboard
	var high_scores = GameData.load_scores()
	for entry in high_scores:
		# Format: "Name - Score"
		var text = str(entry["name"]) + " - " + str(entry["score"])
		leaderboard_list.add_item(text)

	restart_btn.pressed.connect(_on_restart)
	
	var facts = GameData.review_facts.duplicate()
	facts.shuffle()
	
	var review_string = "DID YOU KNOW?\n\n"
	review_string += facts[0] + "\n\n"
	review_string += facts[1] + "\n\n"
	review_string += facts[2]
	
	if review_label:
		review_label.text = review_string

func _on_restart():
	# Reset Score!
	GameData.current_score = 0
	# Go back to Start
	get_tree().change_scene_to_file("res://StartScreen.tscn")
	
