extends Node

var player_hp = 10 :
	set(value):
		player_hp = value
		Utils.save_game()
var gold = 0 :
	set(value):
		gold = value
		Utils.save_game()
