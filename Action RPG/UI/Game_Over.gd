extends Node2D

const PlayerStats = preload("res://Player/PlayerStats.tscn")

func _ready():
	print("Game Over")

func _on_Quit_Button_pressed():
	print("QUIT")
	get_tree().quit()

func _on_Continue_Button_pressed():
	print("Continue")
#	get_node("/root/PlayerStats").queue_free()
#	var playerStats = PlayerStats.instance()
#	get_node("/root").add_child(playerStats,true)
#	get_node("/root/Stats").name = "PlayerStats"
	get_node("/root/PlayerStats").reset()
	get_tree().change_scene("res://World.tscn")
