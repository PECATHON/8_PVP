extends Area3D

# 0 to 9. Set this in Inspector for each sphere!
@export var question_index: int = 0 
# "Easy", "Medium", or "Hard". Set in Inspector!
@export var difficulty_category: String = "Easy"

func _ready():
	body_entered.connect(_on_body_entered)

func _on_body_entered(body):
	if body.name == "Player":
		# 1. Find the UI in the scene tree (it's a sibling or parent)
		# Since we put QuizUI in the Level Root, we can find it:
		var ui = get_tree().current_scene.find_child("QuizUI")
		
		if ui:
			# 2. Get the specific question data
			var list = GameData.get_questions(difficulty_category)
			
			# Safety check
			if question_index < list.size():
				var data = list[question_index]
				# 3. Trigger UI
				ui.show_quiz(data)
				
				# 4. Destroy this orb so we don't hit it again
				queue_free()
			else:
				print("Error: Question Index out of bounds")
