extends Camera2D

onready var player = get_node("/root/World/YSort/Player");
onready var tween = $Tween

export var SCREEN_WIDTH = 288
export var SCREEN_HEIGHT = 224


func _process(delta):
	var x = player.position.x 
	var y = player.position.y
	var screen_space_x = int(x/SCREEN_WIDTH)
	var screen_space_y = int(y/SCREEN_HEIGHT)
	var new_position:Vector2 = Vector2(0,0)
	new_position.x = screen_space_x * 288 + 144
	new_position.y = screen_space_y * 224 + 112
	tween.interpolate_property($".", "position",
		position,new_position, .5,
		Tween.TRANS_LINEAR)
	if new_position != position:
		tween.start()
	else:
		tween.stop($".","position")

func _on_Tween_tween_completed(object, key):
	get_tree().paused = false

func _on_Tween_tween_started(object, key):
	get_tree().paused = true
