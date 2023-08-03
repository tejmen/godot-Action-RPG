extends Node2D

const EnemyDeathEffect = preload("res://Effects/EnemyDeathEffect.tscn")
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _process(delta):
	var enemyDeathEffect = EnemyDeathEffect.instance()
	get_parent().add_child(enemyDeathEffect)
	enemyDeathEffect.global_position = global_position


func _on_Quit_Button_pressed():
	get_tree().quit()
