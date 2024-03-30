extends Node

const SAVE_PATH = "res://savegame.bin"

func save_game():
	var file = FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	var data: Dictionary = {
		"hp" : Game.player_hp,
		"gold": Game.gold
	}
	var json_str = JSON.stringify(data)
	file.store_line(json_str)
	
func load_game():
	var file = FileAccess.open(SAVE_PATH, FileAccess.READ)
	
	if FileAccess.file_exists(SAVE_PATH) == true:
		if not file.eof_reached():
			var json = file.get_line()
			var data = JSON.parse_string(json)
			if data:
				Game.player_hp = data["hp"]
				Game.gold = data["gold"]
