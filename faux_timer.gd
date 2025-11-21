extends Label

var time_left = 120.0 # 2 minutes

func _process(delta):
	# Only count down if the game is NOT paused
	if get_tree().paused:
		time_left -= delta
		
		# Format: 1:59
		var mins = int(time_left) / 60
		var secs = int(time_left) % 60
		text = "%d:%02d" % [mins, secs]
		
		# Make it Red if low
		if time_left < 10:
			modulate = Color.RED
		
		if time_left <= 0:
			time_left = 0
			text = "HURRY!"
