extends Node

var current_score: int = 0
var player_name: String = "Player"
var selected_character: String = "M" 

const SAVE_PATH = "user://leaderboard.save"

var easy_questions = [
	{
		"q": "In Ali Baba, what magic words open the cave?",
		"options": ["Open Sesame", "Open Barley", "Abracadabra", "Open Wheat"]
	},
	{
		"q": "What object does Aladdin use to summon the powerful Genie?",
		"options": ["A Lamp", "A Ring", "A Carpet", "A Coin"]
	},
	{
		"q": "Where does Sindbad the Sailor live?",
		"options": ["Bagdad", "Cairo", "Damascus", "Persia"]
	},
	{
		"q": "In Ali Baba, who is Ali Baba's greedy brother?",
		"options": ["Cassim", "Mustapha", "Hassan", "Ahmed"]
	},
	{
		"q": "Who pretended to be Aladdin's uncle?",
		"options": ["An African Magician", "The Sultan", "A Merchant", "The Vizier"]
	},
	{
		"q": "What giant bird carried Sindbad out of the Valley of Diamonds?",
		"options": ["A Roc", "A Dragon", "A Vulture", "A Griffin"]
	},
	{
		"q": "What did Ali Baba find inside the cave?",
		"options": ["Gold and Jewels", "Weapons", "Food", "Magic Scrolls"]
	}
]

var medium_questions = [
	{
		"q": "In Ali Baba, how did Morgiana kill the thieves hiding in jars?",
		"options": ["Boiling Oil", "Poisonous Gas", "Smoke", "Daggers"]
	},
	{
		"q": "What was Aladdin's father's profession?",
		"options": ["Tailor", "Baker", "Soldier", "Merchant"]
	},
	{
		"q": "In Sindbad's 1st Voyage, what did the island turn out to be?",
		"options": ["A Whale", "A Turtle", "A Moving Rock", "A Submarine"]
	},
	{
		"q": "Who is the clever slave girl who saved Ali Baba?",
		"options": ["Morgiana", "Fatima", "Zubeida", "Scheherazade"]
	},
	{
		"q": "In Sindbad's 3rd Voyage, what did the Giant have in his forehead?",
		"options": ["One Eye", "A Horn", "A Jewel", "A Scar"]
	},
	{
		"q": "How did Aladdin kill the wicked Magician?",
		"options": ["Poisoned Wine", "A Dagger", "The Genie", "Pushed him"]
	},
	{
		"q": "What disguise did the Thief Captain use to enter Ali Baba's house?",
		"options": ["Oil Merchant", "Silk Trader", "Beggar", "Soldier"]
	}
]

var hard_questions = [
	{
		"q": "In Aladdin, who suggested hanging a Roc's egg in the palace?",
		"options": ["The Magician's Brother", "The Princess", "The Vizier", "The Genie"]
	},
	{
		"q": "What did Sindbad hunt in his 7th Voyage?",
		"options": ["Elephants", "Lions", "Whales", "Rhinoceros"]
	},
	{
		"q": "What gift did the King of Serendib send to Caliph Harun-al-Rashid?",
		"options": ["A Ruby Cup", "A Diamond Crown", "A Golden Sword", "A Magic Carpet"]
	},
	{
		"q": "In Ali Baba, who was the poor cobbler that sewed Cassim's body?",
		"options": ["Mustapha", "Abdullah", "Yusuf", "Ibrahim"]
	},
	{
		"q": "How many windows did Aladdin's palace hall have?",
		"options": ["24", "12", "40", "100"]
	},
	{
		"q": "What happened to the trees Sindbad climbed in the 7th Voyage?",
		"options": ["Uprooted by Elephants", "Burned by Pirates", "Cut by Locals", "Blown by Wind"]
	}
]


var review_facts = [
	"1. 'Open Sesame' is the famous password from Ali Baba.",
	"2. Sindbad the Sailor hails from the city of Bagdad.",
	"3. A 'Roc' is a legendary giant bird often found in Arabian tales.",
	"4. Morgiana used boiling oil to defeat the 40 Thieves.",
	"5. Aladdin's father, Mustapha, was a poor tailor.",
	"6. Sindbad's first 'island' was actually a sleeping whale.",
	"7. The Cyclops-like Giant in Sindbad's 3rd voyage had one eye.",
	"8. The King of Serendib gave a Ruby Cup to the Caliph.",
	"9. Aladdin's Palace had 24 windows, one left unfinished.",
	"10. Elephants uprooted trees to show Sindbad their graveyard."
]



func get_questions(difficulty: String):
	match difficulty:
		"Easy": return easy_questions
		"Medium": return medium_questions
		"Hard": return hard_questions
	return easy_questions

func save_score():
	var data = load_scores()
	var new_entry = {
		"name": player_name,
		"score": current_score,
		"date": Time.get_datetime_string_from_system()
	}
	data.append(new_entry)

	data.sort_custom(func(a, b): return a.score > b.score)
	
	var file = FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	file.store_string(JSON.stringify(data))

func load_scores():
	if FileAccess.file_exists(SAVE_PATH):
		var file = FileAccess.open(SAVE_PATH, FileAccess.READ)
		var json = JSON.new()
		var error = json.parse(file.get_as_text())
		if error == OK:
			return json.data
	return []
