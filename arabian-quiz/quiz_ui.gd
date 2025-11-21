extends CanvasLayer
@export var q_label: Label
@export var btn_option_1: Button
@export var btn_option_2: Button
@export var btn_option_3: Button
@export var btn_option_4: Button
@export var feedback: Label
var correct_answer_text = ""
var buttons = []

func _ready():
	buttons = [btn_option_1, btn_option_2, btn_option_3, btn_option_4]
	
	# HIDE the quiz at start
	visible = false
	
	# Connect buttons
	for btn in buttons:
		if btn: # Safety check
			btn.pressed.connect(_on_button_pressed.bind(btn))

func show_quiz(question_dict):
	# 1. Pause the game!
	get_tree().paused = true
	visible = true
	feedback.text = ""
	
	# 2. Set Text
	q_label.text = question_dict["q"]
	correct_answer_text = question_dict["options"][0] # Remember, first one is correct
	
	# 3. Shuffle Options logic
	var opts = question_dict["options"].duplicate()
	opts.shuffle()
	
	# 4. Assign to buttons
	for i in range(4):
		buttons[i].text = opts[i]
		buttons[i].disabled = false

func _on_button_pressed(btn):
	# Disable all buttons so they can't double click
	for b in buttons: b.disabled = true
	
	if btn.text == correct_answer_text:
		feedback.text = "CORRECT!"
		feedback.modulate = Color.GREEN
		GameData.current_score += 10
	else:
		feedback.text = "WRONG! It was: " + correct_answer_text
		feedback.modulate = Color.RED
		# No points
	
	# Wait 1.5 seconds so they can read feedback, then resume
	await get_tree().create_timer(1.5).timeout # Note: This timer works even when paused if process_mode is always?
	# Wait, Timers pause by default. We need a hack or setup.
	# EASIER HACK:
	close_quiz()

func close_quiz():
	visible = false
	get_tree().paused = false
	# Signal or just resume
