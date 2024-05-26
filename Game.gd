extends Node

var save_path = "res://save/game_save.json"

@onready var player = preload("res://Player/Player.tscn").instantiate()


var highscore 
var score

func _ready():
	
	#load save file
	var load_text = load_game()
	
	score = player.coins_collected
	
	highscore = load_text["player"]["highscore"]
	
	print(score)
	
	#highscore handler
	if score > highscore:
		load_text["player"]["highscore"] = score
	
	print(score)
	#save game
	save_game(load_text)

func load_game():
	var file = FileAccess.open(save_path, FileAccess.READ)
	var test_json_conv = JSON.new()
	test_json_conv.parse(file.get_as_text())
	var text = test_json_conv.get_data()
	
	file.close()
	return text

func save_game(data):
	var file = FileAccess.open(save_path, FileAccess.WRITE)
	
	file.store_line(JSON.new().stringify(data))
	
	file.close()

